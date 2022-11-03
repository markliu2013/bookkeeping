import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/components.dart';
import '/commons/commons.dart';
import '/payees/payees.dart';

class PayeeDetailPage extends StatefulWidget {

  final Payee payee;
  PayeeDetailPage({
    required this.payee
  });

  @override
  State<PayeeDetailPage> createState() => _PayeeDetailPageState();
}


class _PayeeDetailPageState extends State<PayeeDetailPage> {

  @override
  void initState() {
    BlocProvider.of<PayeeFetchBloc>(context).add(PayeeLoadDefault(payee: widget.payee));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PayeesBloc, PayeesState>(
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
        BlocListener<PayeesBloc, PayeesState>(
          listenWhen: (previous, current) => previous.toggleStatus != current.toggleStatus,
          listener: (context, state) {
            if (state.toggleStatus == LoadDataStatus.success) {
              Message.success('操作成功！');
              BlocProvider.of<PayeeFetchBloc>(context).add(PayeeFetched());
            }
          },
        )
      ],
      child: BlocBuilder<PayeeFetchBloc, PayeeFetchState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('交易对象详情'),
                actions: _buildActions(context, state.payee ?? widget.payee)
              ),
              body: Builder(
                builder: (context) {
                  switch (state.status) {
                    case LoadDataStatus.progress:
                    case LoadDataStatus.initial:
                      return const PageLoading();
                    case LoadDataStatus.success:
                      return _buildBody(context, state.payee ?? widget.payee);
                    default:
                      return PageError(onTap: () { BlocProvider.of<PayeeFetchBloc>(context).add(PayeeFetched()); });
                  }
                },
              )
          );
        }
        )
    );
  }

  List<Widget> _buildActions(BuildContext context, Payee payee) {
    return [
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          fullDialog(context, PayeeFormPage(type: 2, payee: payee));
        }
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          if (await confirm(
            context,
            content: Text("确定删除${payee.name}吗？"),
            textOK: Text("确定"),
            textCancel: Text("取消"),
          )) {
            BlocProvider.of<PayeesBloc>(context).add(PayeeDeleted(payee.id.toString()));
          }
        }
      )
    ];
  }

  Widget _buildBody(BuildContext context, Payee payee) {
    final theme = Theme.of(context);
    TextStyle? style1 = theme.textTheme.bodyText2;
    TextStyle? style2 = theme.textTheme.bodyText1;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(children: [Text("名称：", style: style1), Text(payee.name, style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("是否可支出：", style: style1), Text(boolToString(payee.expenseable), style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("是否可收入：", style: style1), Text(boolToString(payee.incomeable), style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("备注：", style: style1), Flexible(child: Text(payee.notes ?? '', style: style2))]),
            SizedBox(height: 15),
            Row(children: [Text("是否可用：", style: style1), Text(boolToString(payee.enable), style: style2)]),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(payee.enable ? '禁用' : '启用'),
                onPressed: () {
                  BlocProvider.of<PayeesBloc>(context).add(PayeeToggled(payee.id.toString()));
                }
              ),
            )
          ],
        )
      ),
    );
  }

}