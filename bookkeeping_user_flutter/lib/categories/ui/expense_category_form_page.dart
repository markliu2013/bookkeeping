import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/categories/categories.dart';

class ExpenseCategoryFormPage extends StatelessWidget {

  final int type; // 1-新增，2-修改
  final Category? category;

  const ExpenseCategoryFormPage({
    required this.type,
    this.category
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_buildTitle(type)),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              BlocProvider.of<CategoryFormBloc>(context).add(CategoryFormSubmitted(type, 1, category));
            }
          )
        ]
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              ExpenseCategoryInput(),
              NameInput(),
              SizedBox(height: 10),
              NotesInput(),
              SizedBox(height: 10),
            ],
          ),
        ),
      )
    );
  }

  String _buildTitle(int type) {
    switch (type) {
      case 1:
        return '新增支出分类';
      case 2:
        return '修改支出分类';
      default:
        return '操作类型异常';
    }
  }

}
