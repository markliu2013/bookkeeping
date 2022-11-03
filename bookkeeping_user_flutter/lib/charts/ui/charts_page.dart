import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/charts/charts.dart';

class ChartsPage extends StatefulWidget {
  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> with TickerProviderStateMixin {

  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Builder(
        builder: (context) {
          final tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            setState(() {
              tabIndex = tabController.index;
            });
          });
          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      switch (tabIndex) {
                        case 0:
                          BlocProvider.of<ReportExpenseCategoryBloc>(context).add(ReportExpenseCategoryReset());
                          break;
                        case 1:
                          BlocProvider.of<ReportIncomeCategoryBloc>(context).add(ReportIncomeCategoryReset());
                          break;
                        case 2:
                          BlocProvider.of<ReportAssetBloc>(context).add(ReportAssetLoaded());
                          break;
                        case 3:
                          BlocProvider.of<ReportDebtBloc>(context).add(ReportDebtLoaded());
                          break;
                      }
                    },
                    icon: const Icon(Icons.refresh)
                ),
                title: TabBar(
                  labelPadding: EdgeInsets.all(0),
                  tabs: [
                    Tab(child: Text('支出')),
                    Tab(child: Text('收入')),
                    Tab(child: Text('资产')),
                    Tab(child: Text('负债')),
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: (tabIndex == 2 || tabIndex == 3) ? null : () {
                        if (tabIndex == 0) {
                          Navigator.pushNamed(context, '/charts-expense-category-filter');
                        } else if (tabIndex == 1) {
                          Navigator.pushNamed(context, '/charts-income-category-filter');
                        }
                      },
                      icon: const Icon(Icons.search)
                  )
                ],
              ),
              body: TabBarView(
                  children: [
                    ExpenseCategory(),
                    IncomeCategory(),
                    AssetSheet(),
                    DebtSheet(),
                  ]
              )
          );
        },
      ),
    );
  }
}