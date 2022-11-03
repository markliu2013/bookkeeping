import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/commons.dart';
import '/components/components.dart';
import '/items/items.dart';

class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    BlocProvider.of<ItemsBloc>(context).add(ItemsRefreshed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ItemsBloc, ItemsState>(
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
        BlocListener<ItemsBloc, ItemsState>(
          listenWhen: (previous, current) => previous.deleteStatus != current.deleteStatus,
          listener: (context, state) {
            if (state.deleteStatus == LoadDataStatus.success) {
              BlocProvider.of<ItemsBloc>(context).add(ItemsRefreshed());
            }
          }
        ),
      ],
      child: BlocBuilder<ItemsBloc, ItemsState>(
        buildWhen: (previous, current) => previous.status != current.status || previous.items != current.items,
        builder: (context, state) {
          switch (state.status) {
            case LoadDataStatus.progress:
            case LoadDataStatus.initial:
              return const PageLoading();
            case LoadDataStatus.success:
              if (state.items.isEmpty) return Empty();
              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                controller: _refreshController,
                child: _buildList(context, state.items),
                onRefresh: () async {
                  BlocProvider.of<ItemsBloc>(context).add(ItemsRefreshed());
                  _refreshController.refreshCompleted();
                },
                onLoading: () async {
                  BlocProvider.of<ItemsBloc>(context).add(ItemsLoadMore());
                },
              );
            default:
              return PageError(onTap: () { BlocProvider.of<ItemsBloc>(context).add(ItemsRefreshed()); });
          }

        },
      )
    );
  }

  Widget _buildList(BuildContext context, List<Item> items) {
    final theme = Theme.of(context);
    return ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) {
        Item item = items[index];
        return ListTile(
          dense: true,
          title: Text(item.title, style: theme.textTheme.bodyText1,),
          subtitle: Text(dateFormat(item.nextDate), style: theme.textTheme.caption),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('还有'+item.countDown.toString()+'天', style: theme.textTheme.bodyText2),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
          onTap: () {
            // Navigator.pushNamed(context, '/flow-detail', arguments: FlowDetailArguments(flow: flow));
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

}