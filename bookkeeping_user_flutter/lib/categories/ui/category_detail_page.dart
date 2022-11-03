import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/categories/categories.dart';
import '/commons/commons.dart';
import '/components/components.dart';

class CategoryDetailPage extends StatefulWidget {

  final int categoryType;
  final Category category;

  CategoryDetailPage({
    required this.category,
    required this.categoryType
  });

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();

}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  void initState() {
    BlocProvider.of<CategoryFetchBloc>(context).add(CategoryLoadDefault(category: widget.category));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CategoryTreeBloc, CategoryTreeState>(
          listenWhen: (previous, current) => previous.deleteStatus != current.deleteStatus,
          listener: (context, state) {
            if (state.deleteStatus == LoadDataStatus.success) {
              Message.success('操作成功！');
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              } else {
                SystemNavigator.pop();
              }
            }
          }
        ),
        BlocListener<CategoryTreeBloc, CategoryTreeState>(
          listenWhen: (previous, current) => previous.toggleStatus != current.toggleStatus,
          listener: (context, state) {
            if (state.toggleStatus == LoadDataStatus.success) {
              Message.success('操作成功！');
              BlocProvider.of<CategoryFetchBloc>(context).add(CategoryFetched());
            }
          },
        )
      ],
      child: BlocBuilder<CategoryFetchBloc, CategoryFetchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('类别详情'),
              actions: _buildActions(context, state.category ?? widget.category)
            ),
              body: Builder(
                builder: (context) {
                  switch (state.status) {
                    case LoadDataStatus.progress:
                    case LoadDataStatus.initial:
                      return const PageLoading();
                    case LoadDataStatus.success:
                      return _buildBody(context, state.category ?? widget.category);
                    default:
                      return PageError(onTap: () { BlocProvider.of<CategoryFetchBloc>(context).add(CategoryFetched()); });
                  }
                },
              )
          );
        }
      )
    );
  }

  List<Widget> _buildActions(BuildContext context, Category category) {
    return [
      IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          fullDialog(context, CategoryFormPage(type: 1, categoryType: widget.categoryType, category: category));
        }
      ),
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          fullDialog(context, CategoryFormPage(type: 2, categoryType: widget.categoryType, category: category));
        }
      ),
      IconButton(
          icon: Icon(Icons.delete),
          onPressed: () async {
            if (await confirm(
              context,
              content: Text("确定删除${category.name}吗？"),
              textOK: Text("确定"),
              textCancel: Text("取消"),
            )) {
              BlocProvider.of<CategoryTreeBloc>(context).add(CategoryDeleted(category.id.toString()));
            }
          }
      )
    ];
  }

  Widget _buildBody(BuildContext context, Category category) {
    final theme = Theme.of(context);
    TextStyle? style1 = theme.textTheme.bodyText2;
    TextStyle? style2 = theme.textTheme.bodyText1;
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(children: [Text("名称：", style: style1), Text(category.name, style: style2)]),
              SizedBox(height: 15),
              Row(children: [Text("父级名称：", style: style1), Text(category.parentName ?? '', style: style2)]),
              SizedBox(height: 15),
              Row(children: [Text("是否可用：", style: style1), Text(boolToString(category.enable), style: style2)]),
              SizedBox(height: 15),
              Row(children: [Text("备注：", style: style1), Flexible(child: Text(category.notes ?? '', style: style2))]),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(category.enable ? '禁用' : '启用'),
                  onPressed: () {
                    BlocProvider.of<CategoryTreeBloc>(context).add(CategoryToggled(category.id.toString()));
                  }
                ),
              )
            ],
          )
      ),
    );
  }

}
