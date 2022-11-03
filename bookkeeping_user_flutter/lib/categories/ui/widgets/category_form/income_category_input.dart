import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_select/awesome_select.dart';
import '/commons/commons.dart';
import '/categories/categories.dart';

class IncomeCategoryInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state1 = context.watch<IncomeCategorySelectBloc>().state;
    return BlocBuilder<CategoryFormBloc, CategoryFormState>(
      buildWhen: (previous, current) => previous.request.parentId != current.request.parentId,
      builder: (context, state) {
        return SmartSelect<String>.single
          (
            title: '父级分类',
            selectedValue: state.request.parentId ?? '',
            onChange: (selected) {
              context.read<CategoryFormBloc>().add(CategoryFormParentChanged(selected.value ?? ''));
            },
            choiceItems: state1 is IncomeCategorySelectStateLoadSuccess ? modelToChoice(state1.categories) : [],
            choiceType: S2ChoiceType.chips,
            modalFilter: true,
            modalFilterAuto: true,
            tileBuilder: (context, state) {
              return S2Tile.fromState(
                state,
                isLoading: state1 is IncomeCategorySelectStateLoadInProgress,
                padding: EdgeInsets.zero,
              );
            }
        );
      }
    );
  }
}