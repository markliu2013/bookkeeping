import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/charts/charts.dart';

class ChartsIncomeCategoryFilterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('搜索'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              BlocProvider.of<ReportIncomeCategoryBloc>(context).add(ReportIncomeCategoryRefreshed());
              Navigator.pop(context);
            },
          ),
        ]
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              DateInputIncome(),
              IncomeCategoryInput()
            ],
          ),
        )
      ),
    );
  }
}
