import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/components.dart';
import '/commons/commons.dart';
import '/accounts/accounts.dart';
import '/login/login.dart';

class AccountDetailPage extends StatefulWidget {

  final Account account;
  AccountDetailPage({
    required this.account
  });

  @override
  State<AccountDetailPage> createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {

  @override
  void initState() {
    BlocProvider.of<AccountFetchBloc>(context).add(AccountLoadDefault(account: widget.account));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AccountsBloc, AccountsState>(
          listenWhen: (previous, current) => previous.deleteStatus != current.deleteStatus,
          listener: (context, state) {
            if (state.deleteStatus == LoadDataStatus.success) {
              Message.success('操作成功！');
              // Navigator.pop(context);
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              } else {
                SystemNavigator.pop();
              }
            }
          }
        ),
        BlocListener<AccountsBloc, AccountsState>(
          listenWhen: (previous, current) => previous.toggleStatus != current.toggleStatus,
          listener: (context, state) {
            if (state.toggleStatus == LoadDataStatus.success) {
              Message.success('操作成功！');
              BlocProvider.of<AccountFetchBloc>(context).add(AccountFetched());
            }
          },
        )
      ],
      child: BlocBuilder<AccountFetchBloc, AccountFetchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('账户详情'),
              actions: _buildActions(context, state.account ?? widget.account)
            ),
            body: Builder(
              builder: (context) {
                switch (state.status) {
                  case LoadDataStatus.progress:
                  case LoadDataStatus.initial:
                    return const PageLoading();
                  case LoadDataStatus.success:
                    return _buildBody(context, state.account ?? widget.account);
                  default:
                    return PageError(onTap: () { BlocProvider.of<AccountFetchBloc>(context).add(AccountFetched()); });
                }
              },
            )
          );
        }
      )
    );
  }

  List<Widget> _buildActions(BuildContext context, Account account) {
    return [
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          fullDialog(context, AccountFormPage(type: 2, accountType: account.type, account: account));
        }
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          if (await confirm(
            context,
            content: Text("确定删除${account.name}吗？"),
            textOK: Text("确定"),
            textCancel: Text("取消"),
          )) {
            BlocProvider.of<AccountsBloc>(context).add(AccountDeleted(account.id.toString()));
          }
        }
      )
    ];
  }

  Widget _buildBody(BuildContext context, Account account) {
    final theme = Theme.of(context);
    TextStyle? style1 = theme.textTheme.bodyText2;
    TextStyle? style2 = theme.textTheme.bodyText1;
    final state = context.watch<AuthBloc>().state;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(children: [Text("账户类型：", style: style1), Text(account.typeName, style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("账户名称：", style: style1), Text(account.name, style: style2)]),
            Row(children: [
              Text("余额：", style: style1),
              Text(removeDecimalZero(account.balance), style: style2),
              SizedBox(width: 10),
              TextButton(
                  child: const Text('余额调整'),
                  onPressed: () {
                    fullDialog(context, AccountAdjustBalance(account: account));
                  }
              ),
            ]),
            Row(children: [Text("币种：", style: style1), Text(account.currencyCode, style: style2)]),
            SizedBox(height: 15),
            if (account.currencyCode != state.session?.defaultGroup.defaultCurrencyCode)
              Row(children: [Text("折合${state.session?.defaultGroup.defaultCurrencyCode}：", style: style1), Text(removeDecimalZero(account.convertedBalance!), style: style2)]),
            if (account.currencyCode != state.session?.defaultGroup.defaultCurrencyCode) SizedBox(height: 15),
            if (account.limit != null) Row(children: [Text("信用额度：", style: style1), Text(removeDecimalZero(account.limit!), style: style2)]),
            if (account.limit != null) SizedBox(height: 15),
            if (account.remainLimit != null) Row(children: [Text("剩余额度：", style: style1), Text(removeDecimalZero(account.remainLimit!), style: style2)]),
            if (account.remainLimit != null) SizedBox(height: 15),
            if (account.type == 2) Row(children: [Text("账单日：", style: style1), Text(account.billDay?.toString() ?? '', style: style2)]),
            if (account.type == 2) SizedBox(height: 15),
            if (account.type == 3) Row(children: [Text("年化利率(%)：", style: style1), Text(account.apr?.toString() ?? '', style: style2)]),
            if (account.type == 3) SizedBox(height: 15),
            if (account.type == 4) Row(children: [Text("更新日期：", style: style1), Text(dateFormat(account.asOfDate), style: style2)]),
            if (account.type == 4) SizedBox(height: 15),
            Row(children: [Text("是否可用：", style: style1), Text(boolToString(account.enable), style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("是否计入净资产：", style: style1), Text(boolToString(account.include), style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("是否可支出：", style: style1), Text(boolToString(account.expenseable), style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("是否可收入：", style: style1), Text(boolToString(account.incomeable), style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("是否可转入：", style: style1), Text(boolToString(account.transferToAble), style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("是否可转出：", style: style1), Text(boolToString(account.transferFromAble), style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("初始余额：", style: style1), Text(removeDecimalZero(account.initialBalance), style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("备注：", style: style1), Flexible(child: Text(account.notes ?? '', style: style2))]),
            account.no != null && account.no!.isNotEmpty ? SizedBox(height: 0) : SizedBox(height: 15),
            Row(children: [
              Text("卡号：", style: style1),
              Flexible(child: Text(account.no ?? '', style: style2)),
              SizedBox(width: 10),
              account.no != null && account.no!.isNotEmpty ? TextButton(
                  child: const Text('复制卡号'),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: account.no)).then((_) => Message.success('卡号复制成功'));
                  }
              ) : Text(''),
            ]),
            account.no != null && account.no!.isNotEmpty ? SizedBox(height: 0) : SizedBox(height: 15),
            SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  child: Text(account.enable ? '禁用' : '启用'),
                  onPressed: () {
                    BlocProvider.of<AccountsBloc>(context).add(AccountToggled(account.id.toString()));
                  }
              ),
            ),
            SizedBox(height: 15),
          ],
        )
      ),
    );
  }

}