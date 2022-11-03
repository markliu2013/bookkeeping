import 'package:bookkeeping_user_flutter/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '/commons/commons.dart';
import '/components/components.dart';
import '/flows/flows.dart';
import '/add_flow/add_flow.dart';
import 'widgets/widgets.dart';

class FlowsPage extends StatefulWidget {
  @override
  State<FlowsPage> createState() => _FlowsPageState();
}

class _FlowsPageState extends State<FlowsPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    BlocProvider.of<FlowsBloc>(context).add(FlowsRefreshed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FlowsBloc, FlowsState>(
          listenWhen: (previous, current) => previous.loadMoreStatus != current.loadMoreStatus,
          listener: (context, state) {
            if (state.loadMoreStatus == LoadDataStatus.success) {
              _refreshController.loadComplete();
            } else if (state.loadMoreStatus == LoadDataStatus.failure) {
              _refreshController.loadFailed();
            } else if (state.loadMoreStatus == LoadDataStatus.empty) {
              _refreshController.loadNoData();
            }
          }
        ),
        BlocListener<FlowsBloc, FlowsState>(
          listenWhen: (previous, current) => previous.deleteStatus != current.deleteStatus,
          listener: (context, state) {
            if (state.deleteStatus == LoadDataStatus.success) {
              // 不加延迟刷新会黑屏，原因未知。 TODO
              // await Future.delayed(const Duration(milliseconds: 500));
              BlocProvider.of<FlowsBloc>(context).add(FlowsRefreshed());
            }
          }
        ),
        BlocListener<FlowsBloc, FlowsState>(
          listenWhen: (previous, current) => previous.confirmStatus != current.confirmStatus,
          listener: (context, state) {
            if (state.confirmStatus == LoadDataStatus.success) {
              BlocProvider.of<FlowsBloc>(context).add(FlowsRefreshed());
            }
          }
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                BlocProvider.of<FlowsBloc>(context).add(FlowsReset());
              },
              icon: const Icon(Icons.refresh)
          ),
          title: const Text("流水"),
          centerTitle: true,
          actions: [
            OrderButton(),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/flows-filter');
              },
              icon: const Icon(Icons.search)
            )
          ],
        ),
        body: BlocBuilder<FlowsBloc, FlowsState>(
          buildWhen: (previous, current) => previous.status != current.status || previous.flows != current.flows,
          builder: (context, state) {
            switch (state.status) {
              case LoadDataStatus.progress:
              case LoadDataStatus.initial:
                return const PageLoading();
              case LoadDataStatus.success:
                if (state.flows.isEmpty) return Empty();
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: _refreshController,
                  child: _buildList(context, state.flows),
                  onRefresh: () async {
                    BlocProvider.of<FlowsBloc>(context).add(FlowsRefreshed());
                    _refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    BlocProvider.of<FlowsBloc>(context).add(FlowsLoadMore());
                  },
                );
              default:
                return PageError(onTap: () { BlocProvider.of<FlowsBloc>(context).add(FlowsRefreshed()); });
            }
          }
        )
      )
    );
  }

  Widget _buildList(BuildContext context, List<FlowModel> flows) {
    final theme = Theme.of(context);
    return ListView.separated(
      itemCount: flows.length,
      itemBuilder: (context, index) {
        FlowModel flow = flows[index];
        TextStyle amountStyle = theme.textTheme.headline6 ?? TextStyle(fontWeight: FontWeight.w500, fontSize: 20);
        if (flow.type == 1) amountStyle = amountStyle.copyWith(color: Colors.green);
        if (flow.type == 2) amountStyle = amountStyle.copyWith(color: Colors.red);
        return ListTile(
          dense: true,
          title: Text(flow.title, style: theme.textTheme.bodyText1),
          subtitle: Text(flow.subTitle, style: theme.textTheme.caption),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(flow.amountFormatted, style: amountStyle),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/flow-detail', arguments: FlowDetailArguments(flow: flow));
          },
          onLongPress: flow.type != 4 ? () {
            fullDialog(context, AddFlowPage(type: 3, flow: flow));
          } : null,
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}