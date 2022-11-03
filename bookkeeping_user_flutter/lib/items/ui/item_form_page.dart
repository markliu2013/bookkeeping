import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '/commons/commons.dart';
import '/items/items.dart';

class ItemFormPage extends StatelessWidget {

  final int type; // 1-新增，2-修改
  final Item? item;

  const ItemFormPage({
    required this.type,
    this.item
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemFormBloc(itemRepository: RepositoryProvider.of<ItemRepository>(context))..add(ItemFormDefaultLoaded(type, item)),
      child: BlocListener<ItemFormBloc, ItemFormState>(
        listener: (context, state) {
          if (state.status == FormzStatus.submissionSuccess) {
            Message.success('操作成功');
            Navigator.of(context).pop();
            BlocProvider.of<ItemsBloc>(context).add(ItemsRefreshed());
            if (type == 2) {
              //BlocProvider.of<ItemFetchBloc>(context).add(PayeeFetched());
            }
          }
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(_buildTitle(type)),
                actions: [
                  IconButton(
                    icon: Icon(Icons.done),
                    onPressed: () {
                      if (type == 1) {
                        BlocProvider.of<ItemFormBloc>(context).add(ItemFormAddSubmitted());
                      } else if (type == 2) {
                        // BlocProvider.of<ItemFormBloc>(context).add(PayeeFormSubmitted(type, payee));
                      }
                    }
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      TitleInput(),
                      SizedBox(height: 10),
                      DateInput()
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),

    );
  }

  String _buildTitle(int type) {
    switch (type) {
      case 1:
        return '新增项目';
      case 2:
        return '修改项目';
      default:
        return '类型异常';
    }
  }

}
