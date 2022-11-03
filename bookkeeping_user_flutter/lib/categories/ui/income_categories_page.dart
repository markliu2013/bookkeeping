import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/routes.dart';
import '/components/components.dart';
import '/commons/commons.dart';
import '/categories/categories.dart';

class IncomeCategoryPage extends StatefulWidget {
  @override
  State<IncomeCategoryPage> createState() => _IncomeCategoryPageState();
}

class _IncomeCategoryPageState extends State<IncomeCategoryPage> {

  @override
  void initState() {
    BlocProvider.of<CategoryTreeBloc>(context).add(IncomeCategoryTreeRefreshed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CategoryTreeBloc>().state;
    return MultiBlocListener(
      listeners: [
        BlocListener<CategoryTreeBloc, CategoryTreeState>(
          listenWhen: (previous, current) => previous.deleteStatus != current.deleteStatus,
          listener: (context, state) {
            if (state.deleteStatus == LoadDataStatus.success) {
              BlocProvider.of<CategoryTreeBloc>(context).add(IncomeCategoryTreeRefreshed());
            }
          },
        ),
        BlocListener<CategoryTreeBloc, CategoryTreeState>(
          listenWhen: (previous, current) => previous.toggleStatus != current.toggleStatus,
          listener: (context, state) {
            if (state.toggleStatus == LoadDataStatus.success) {
              BlocProvider.of<CategoryTreeBloc>(context).add(IncomeCategoryTreeRefreshed());
            }
          },
        ),
      ],
      child: WillPopScope(
        onWillPop: () => _onWillPop(state),
        child: BlocBuilder<CategoryTreeBloc, CategoryTreeState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('收入类别'),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      fullDialog(context, CategoryFormPage(type: 1, categoryType: 2));
                    }
                  )
                ]
              ),
              body: Builder(
                builder: (BuildContext context) {
                  switch (state.status) {
                    case LoadDataStatus.progress:
                    case LoadDataStatus.initial:
                      return const PageLoading();
                    case LoadDataStatus.success:
                      if (state.currentCategories.isEmpty) return Empty();
                      return _buildList(context, state.currentCategories);
                    default:
                      return PageError(onTap: () { BlocProvider.of<CategoryTreeBloc>(context).add(IncomeCategoryTreeRefreshed()); });
                  }
                },
              ),
            );
          },
        )
      ),
    );
  }

  Widget _buildList(BuildContext context, List<CategoryTree> categories) {
    final theme = Theme.of(context);
    return ListView.separated(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        CategoryTree categoryTree = categories[index];
        return ListTile(
          dense: true,
          title: Text(categoryTree.name, style: theme.textTheme.bodyText1),
          subtitle: categoryTree.notes != null && categoryTree.notes!.isNotEmpty ? Text(categoryTree.notes!, style: theme.textTheme.caption) : null,
          trailing: categoryTree.children != null && categoryTree.children!.isNotEmpty ? Icon(Icons.keyboard_arrow_right) : null,
          onTap: () {
            if (categoryTree.children != null && categoryTree.children!.isNotEmpty) {
              BlocProvider.of<CategoryTreeBloc>(context).add(CategoryItemClicked(categoryTree: categoryTree));
            } else {
              Navigator.pushNamed(context, '/category-detail', arguments: CategoryDetailArguments(category: Category.fromTree(categoryTree), categoryType: 2));
            }
          },
          onLongPress: () {
            Navigator.pushNamed(context, '/category-detail', arguments: CategoryDetailArguments(category: Category.fromTree(categoryTree), categoryType: 2));
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Future<bool> _onWillPop(state) async {
    if (state.currentLevel == 1) return true;
    BlocProvider.of<CategoryTreeBloc>(context).add(CategoryBackClicked());
    return false;
  }

}