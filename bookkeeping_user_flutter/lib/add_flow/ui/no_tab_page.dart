import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/components.dart';
import '/accounts/accounts.dart';
import '/flows/flows.dart';
import '/add_flow/add_flow.dart';

class NoTabPage extends StatelessWidget {

  final int type; // 1-新增，2-修改，3-复制，4-退款
  final FlowModel flow;

  NoTabPage({
    required this.type,
    required this.flow
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_buildTitle(type, flow)),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              switch (flow.type) {
                case 1:
                  BlocProvider.of<AddExpenseBloc>(context).add(AddExpenseSubmitted(type, flow.expense));
                  break;
                case 2:
                  BlocProvider.of<AddIncomeBloc>(context).add(AddIncomeSubmitted(type, flow.income));
                  break;
                case 3:
                  BlocProvider.of<AddTransferBloc>(context).add(AddTransferSubmitted(type, flow.transfer));
                  break;
                case 4:
                  BlocProvider.of<AccountAdjustBalanceBloc>(context).add(AccountAdjustBalanceSubmitted(2, null, flow.adjustBalance));
                  break;
                default:
                  break;
              }
            },
          )
        ]
      ),
      body: _buildBody(flow)
    );
  }

  Widget _buildBody(FlowModel flow) {
    switch (flow.type) {
      case 1:
        return AddExpenseForm(type: type);
      case 2:
        return AddIncomeForm(type: type);
      case 3:
        return AddTransferForm(type: type);
      case 4:
        return AdjustBalanceForm(type: type, adjustBalance: flow.adjustBalance);
      default:
        return PageError(msg: '账单类型异常');
    }
  }

  String _buildTitle(int type, FlowModel flow) {
    switch (type) {
      case 2:
        return '修改${flow.typeName}';
      case 3:
        return '复制${flow.typeName}';
      case 4:
        return '${flow.typeName}退款';
      default:
        return '账单操作类型异常';
    }
  }

}
