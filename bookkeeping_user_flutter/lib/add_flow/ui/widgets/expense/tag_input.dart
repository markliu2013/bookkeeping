import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_select/awesome_select.dart';

import '/commons/commons.dart';
import '/add_flow/add_flow.dart';
import '/tags/tags.dart';

class TagInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state1 = context.watch<TagExpenseableBloc>().state;
    return BlocSelector<AddExpenseBloc, AddExpenseState, List<String>?>(
      selector: (state) => state.request.tags,
      builder: (context, state) {
        return
          SmartSelect<String>.multiple(
            key: Key(new DateTime.now().millisecondsSinceEpoch.toString()),
            title: '标签',
            selectedValue: state ?? [],
            onChange: (selected) {
              context.read<AddExpenseBloc>().add(AddExpenseTagChanged(selected!.value ?? []));
            },
            choiceItems: state1 is TagExpenseableStateLoadSuccess ? modelToChoice(state1.tags) : [],
            choiceType: S2ChoiceType.chips,
            modalFilter: true,
            modalFilterAuto: true,
            tileBuilder: (context, state) {
              return S2Tile.fromState(
                state,
                isLoading: state1 is TagExpenseableStateLoadInProgress,
                padding: EdgeInsets.zero,
              );
            }
          );
      }
    );
  }
}