import 'package:flutter/material.dart';
import '/commons/commons.dart';
import '/items/items.dart';

class ItemsIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('提醒事项'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fullDialog(context, ItemFormPage(type: 1));
        },
        child: const Icon(Icons.add),
      ),
      body: ItemsPage(),
    );
  }

}
