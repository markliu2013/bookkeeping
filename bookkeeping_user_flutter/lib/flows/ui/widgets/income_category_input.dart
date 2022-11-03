import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_select/awesome_select.dart';

import '/commons/commons.dart';
import '/flows/flows.dart';
import '/categories/categories.dart';

class IncomeCategoryInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state1 = context.watch<IncomeCategorySelectBloc>().state;
    return BlocSelector<FlowsBloc, FlowsState, List<String>?>(
      selector: (state) => state.request.categories,
      builder: (context, state) {
        return
          SmartSelect<String>.single
            (
              title: '收入分类',
              selectedValue: state?.first ?? '',
              onChange: (selected) {
                context.read<FlowsBloc>().add(FlowsFilterCategoryChanged(selected.value ?? ''));
              },
              choiceItems: state1 is IncomeCategorySelectStateLoadSuccess ? modelToChoice(state1.categories) : [],
              choiceType: S2ChoiceType.chips,
              modalFilter: true,
              modalFilterAuto:true,
              tileBuilder: (context, state) {
                return S2Tile.fromState(
                  state,
                  isLoading: state1 is IncomeCategorySelectStateLoadInProgress,
                );
              }
          );
      }
    );
  }
}