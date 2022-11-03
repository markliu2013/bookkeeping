import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_select/awesome_select.dart';

import '/commons/commons.dart';
import '/flows/flows.dart';
import '/categories/categories.dart';

class ExpenseCategoryInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state1 = context.watch<ExpenseCategorySelectBloc>().state;
    return BlocSelector<FlowsBloc, FlowsState, List<String>?>(
      selector: (state) => state.request.categories,
      builder: (context, state) {
        return
          SmartSelect<String>.single
            (
              title: '支出分类',
              selectedValue: state?.first ?? '',
              onChange: (selected) {
                context.read<FlowsBloc>().add(FlowsFilterCategoryChanged(selected.value ?? ''));
              },
              choiceItems: state1 is ExpenseCategorySelectStateLoadSuccess ? modelToChoice(state1.categories) : [],
              choiceType: S2ChoiceType.chips,
              modalFilter: true,
              modalFilterAuto:true,
              tileBuilder: (context, state) {
                return S2Tile.fromState(
                  state,
                  isLoading: state1 is ExpenseCategorySelectStateLoadInProgress,
                );
              }
          );
      }
    );
  }
}