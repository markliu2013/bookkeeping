import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/add_flow/add_flow.dart';

class TabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
            title: TabBar(
              labelPadding: EdgeInsets.all(0),
              tabs: [
                Tab(child: Text('支出')),
                Tab(child: Text('收入')),
                Tab(child: Text('转账')),
              ],
            ),
            actions: [
              // 必须加Builder包装，否则DefaultTabController.of(context)找不到。
              Builder(builder: (context) {
                return IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () {
                    switch (DefaultTabController.of(context)!.index) {
                      case 0:
                        BlocProvider.of<AddExpenseBloc>(context).add(AddExpenseSubmitted(1, null));
                        break;
                      case 1:
                        BlocProvider.of<AddIncomeBloc>(context).add(AddIncomeSubmitted(1, null));
                        break;
                      case 2:
                        BlocProvider.of<AddTransferBloc>(context).add(AddTransferSubmitted(1, null));
                        break;
                      default:
                        break;
                    }
                  },
                );
              })
            ]
        ),
        body: TabBarView(
          children: [
            AddExpenseForm(type: 1),
            AddIncomeForm(type: 1),
            AddTransferForm(type: 1),
          ],
        ),
      ),
    );
  }
}
