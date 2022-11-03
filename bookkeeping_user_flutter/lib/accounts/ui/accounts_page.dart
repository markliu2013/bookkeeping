import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '/routes.dart';
import '/commons/commons.dart';
import '/components/components.dart';
import '/accounts/accounts.dart';

class AccountsPage extends StatefulWidget {
  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

// https://stackoverflow.com/questions/68013459/how-to-use-multiple-tab-for-single-page-in-flutter
class _AccountsPageState extends State<AccountsPage> with TickerProviderStateMixin {

  late TabController tabController;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    BlocProvider.of<AccountsBloc>(context).add(AccountsRefreshed());
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      if(!tabController.indexIsChanging) {
        BlocProvider.of<AccountsBloc>(context).add(AccountsTabChanged(tabController.index));
        BlocProvider.of<AccountsBloc>(context).add(AccountsRefreshed());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AccountsBloc, AccountsState>(
          listenWhen: (previous, current) =>
          previous.loadMoreStatus != current.loadMoreStatus,
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
        BlocListener<AccountsBloc, AccountsState>(
          listenWhen: (previous, current) =>
          previous.deleteStatus != current.deleteStatus,
          listener: (context, state) {
            if (state.deleteStatus == LoadDataStatus.success) {
              BlocProvider.of<AccountsBloc>(context).add(AccountsRefreshed());
            }
          },
        ),
        BlocListener<AccountsBloc, AccountsState>(
          listenWhen: (previous, current) =>
          previous.toggleStatus != current.toggleStatus,
          listener: (context, state) {
            if (state.toggleStatus == LoadDataStatus.success) {
              BlocProvider.of<AccountsBloc>(context).add(AccountsRefreshed());
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              BlocProvider.of<AccountsBloc>(context).add(AccountsRefreshed());
            },
            icon: const Icon(Icons.refresh)
          ),
          centerTitle: true,
          title: TabBar(
            controller: tabController,
            labelPadding: EdgeInsets.all(0),
            tabs: [
              Tab(child: Text('活期', softWrap: false)),
              Tab(child: Text('信用', softWrap: false)),
              Tab(child: Text('贷款', softWrap: false)),
              Tab(child: Text('资产', softWrap: false)),
            ],
          ),
          actions: [
            OrderButton(),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                fullDialog(context, AccountFormPage(type: 1, accountType: tabController.index + 1));
              }
            )
          ]
        ),
        body: BlocBuilder<AccountsBloc, AccountsState>(
          buildWhen: (previous, current) => previous.status != current.status || previous.accounts != current.accounts,
          builder: (context, state) {
            switch (state.status) {
              case LoadDataStatus.progress:
              case LoadDataStatus.initial:
                return const PageLoading();
              case LoadDataStatus.success:
                if (state.accounts.isEmpty) return Empty();
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: _refreshController,
                  child: _buildList(context, state.accounts),
                  onRefresh: () async {
                    BlocProvider.of<AccountsBloc>(context).add(AccountsRefreshed());
                    _refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    BlocProvider.of<AccountsBloc>(context).add(AccountsLoadMore());
                  },
                );
              default:
                return PageError(onTap: () {
                  BlocProvider.of<AccountsBloc>(context).add(AccountsRefreshed());
                });
            }
          }
        )
      )
    );
  }

  Widget _buildList(BuildContext context, List<Account> accounts) {
    final theme = Theme.of(context);
    return ListView.separated(
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        Account account = accounts[index];
        return ListTile(
          dense: false,
          title: Text(account.name, style: theme.textTheme.bodyText1),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(account.balance.toStringAsFixed(2), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/account-detail', arguments: AccountDetailArguments(account: account));
          },
          onLongPress: () {
            fullDialog(context, AccountAdjustBalance(account: account));
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

}