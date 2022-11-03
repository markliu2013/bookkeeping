import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '/components/components.dart';
import '/commons/commons.dart';
import '/categories/categories.dart';

class CategoryFormPage extends StatelessWidget {

  final int type; // 1-新增，2-修改
  final int categoryType;
  final Category? category;

  const CategoryFormPage({
    required this.type,
    required this.categoryType,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryFormBloc(
        categoryRepository: RepositoryProvider.of<CategoryRepository>(context),
        expenseCategorySelectBloc: BlocProvider.of<ExpenseCategorySelectBloc>(context),
        incomeCategorySelectBloc: BlocProvider.of<IncomeCategorySelectBloc>(context)
      )..add(CategoryFormDefaultLoaded(type, categoryType, category)),
      child: BlocListener<CategoryFormBloc, CategoryFormState>(
        listener: (context, state) {
          if (state.status == FormzStatus.submissionSuccess) {
            Message.success('操作成功');
            Navigator.of(context).pop();
            if (categoryType == 1) {
              BlocProvider.of<CategoryTreeBloc>(context).add(ExpenseCategoryTreeRefreshed());
            } else if (categoryType == 2) {
              BlocProvider.of<CategoryTreeBloc>(context).add(IncomeCategoryTreeRefreshed());
            }
            if (type == 2) {
              BlocProvider.of<CategoryFetchBloc>(context).add(CategoryFetched());
            }
          }
        },
        child: Builder(
          builder: (context) {
            switch (categoryType) {
              case 1:
                return ExpenseCategoryFormPage(type: type, category: category);
              case 2:
                return IncomeCategoryFormPage(type: type, category: category);
              default:
                return PageError(msg: '分类类型错误');
            }
          },
        )
      )
    );
  }

}
