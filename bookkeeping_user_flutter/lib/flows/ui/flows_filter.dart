import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/flows/flows.dart';
import 'widgets/widgets.dart';

class FlowsFilterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('搜索流水'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              BlocProvider.of<FlowsBloc>(context).add(FlowsRefreshed());
              Navigator.pop(context);
            },
          ),
        ]
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              DateInput(),
              PayeeInput(),
              TagInput(),
              ExpenseCategoryInput(),
              IncomeCategoryInput(),
              TypeInput(),
              AccountInput(),
              StatusInput(),
            ],
          )
        )
      )
    );
  }
}