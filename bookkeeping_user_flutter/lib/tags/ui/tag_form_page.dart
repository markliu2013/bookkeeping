import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '/components/components.dart';
import '/commons/commons.dart';
import '/tags/tags.dart';

class TagFormPage extends StatelessWidget {

  final int type; // 1-新增，2-修改
  final Tag? tag;

  const TagFormPage({
    required this.type,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TagFormBloc(
        tagRepository: RepositoryProvider.of<TagRepository>(context),
        tagExpenseableBloc: BlocProvider.of<TagExpenseableBloc>(context),
        tagIncomeableBloc: BlocProvider.of<TagIncomeableBloc>(context),
        tagTransferableBloc: BlocProvider.of<TagTransferableBloc>(context),
        tagEnableBloc: BlocProvider.of<TagEnableBloc>(context),
      )..add(TagFormDefaultLoaded(type, tag)),
      child: BlocListener<TagFormBloc, TagFormState>(
        listener: (context, state) {
          if (state.status == FormzStatus.submissionSuccess) {
            Message.success('操作成功');
            Navigator.of(context).pop();
            BlocProvider.of<TagTreeBloc>(context).add(TagTreeRefreshed());
            if (type == 2) {
              BlocProvider.of<TagFetchBloc>(context).add(TagFetched());
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
                      BlocProvider.of<TagFormBloc>(context).add(TagFormSubmitted(type, tag));
                    }
                  )
                ]
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      ParentInput(),
                      SizedBox(height: 10),
                      NameInput(),
                      SizedBox(height: 10),
                      ExpenseableSwitch(),
                      SizedBox(height: 10),
                      IncomeableSwitch(),
                      SizedBox(height: 10),
                      TransferableSwitch(),
                      SizedBox(height: 10),
                      NotesInput()
                    ],
                  ),
                ),
              )
            );
          },
        )
      )
    );
  }

  String _buildTitle(int type) {
    switch (type) {
      case 1:
        return '新增标签';
      case 2:
        return '修改标签';
      default:
        return '操作类型异常';
    }
  }

}
