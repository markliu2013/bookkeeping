import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '/routes.dart';
import '/commons/commons.dart';
import '/payees/payees.dart';
import '/components/components.dart';

class PayeesPage extends StatefulWidget {
  @override
  State<PayeesPage> createState() => _PayeesPageState();
}

class _PayeesPageState extends State<PayeesPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    BlocProvider.of<PayeesBloc>(context).add(PayeesRefreshed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PayeesBloc, PayeesState>(
          listenWhen: (previous, current) => previous.loadMoreStatus != current.loadMoreStatus,
          listener: (context, state) {
            if (state.loadMoreStatus == LoadDataStatus.success) {
              _refreshController.loadComplete();
            } else if (state.loadMoreStatus == LoadDataStatus.failure) {
              _refreshController.loadFailed();
            } else if (state.loadMoreStatus == LoadDataStatus.empty) {
              _refreshController.loadNoData();
            }
          },
        ),
        BlocListener<PayeesBloc, PayeesState>(
          listenWhen: (previous, current) => previous.deleteStatus != current.deleteStatus,
          listener: (context, state) {
            if (state.deleteStatus == LoadDataStatus.success) {
              BlocProvider.of<PayeesBloc>(context).add(PayeesRefreshed());
            }
          },
        ),
        BlocListener<PayeesBloc, PayeesState>(
          listenWhen: (previous, current) => previous.toggleStatus != current.toggleStatus,
          listener: (context, state) {
            if (state.toggleStatus == LoadDataStatus.success) {
              BlocProvider.of<PayeesBloc>(context).add(PayeesRefreshed());
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("交易对象"),
          centerTitle: true,
          actions: [
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  fullDialog(context, PayeeFormPage(type: 1));
                }
            )
          ]
        ),
        body: BlocBuilder<PayeesBloc, PayeesState>(
          buildWhen: (previous, current) => previous.status != current.status || previous.payees != current.payees,
          builder: (context, state) {
            switch (state.status) {
              case LoadDataStatus.progress:
              case LoadDataStatus.initial:
                return const PageLoading();
              case LoadDataStatus.success:
                if (state.payees.isEmpty) return Empty();
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: _refreshController,
                  child: _buildList(context, state.payees),
                  onRefresh: () async {
                    BlocProvider.of<PayeesBloc>(context).add(PayeesRefreshed());
                    _refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    BlocProvider.of<PayeesBloc>(context).add(PayeesLoadMore());
                  },
                );
              default:
                return PageError(onTap: () { BlocProvider.of<PayeesBloc>(context).add(PayeesRefreshed()); });
            }
          }
        ),
      )
    );
  }

  Widget _buildList(BuildContext context, List<Payee> payees) {
    final theme = Theme.of(context);
    return ListView.separated(
      itemCount: payees.length,
      itemBuilder: (context, index) {
        Payee payee = payees[index];
        return ListTile(
          dense: true,
          title: Text(payee.name, style: theme.textTheme.bodyText1,),
          subtitle: payee.notes != null && payee.notes!.isNotEmpty ? Text(payee.notes!, style: theme.textTheme.caption) : null,
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.pushNamed(context, '/payee-detail', arguments: PayeeDetailArguments(payee: payee));
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

}