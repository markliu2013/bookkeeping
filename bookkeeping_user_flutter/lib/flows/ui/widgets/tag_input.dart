import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_select/awesome_select.dart';

import '/commons/commons.dart';
import '/flows/flows.dart';
import '/tags/tags.dart';

class TagInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state1 = context.watch<TagEnableBloc>().state;
    return BlocSelector<FlowsBloc, FlowsState, List<String>?>(
      selector: (state) => state.request.tags,
      builder: (context, state) {
        return
          SmartSelect<String>.single
            (
              title: '交易标签',
              selectedValue: state?.first ?? '',
              onChange: (selected) {
                context.read<FlowsBloc>().add(FlowsFilterTagChanged(selected.value ?? ''));
              },
              choiceItems: state1 is TagEnableStateLoadSuccess ? modelToChoice(state1.tags) : [],
              choiceType: S2ChoiceType.chips,
              modalFilter: true,
              modalFilterAuto:true,
              tileBuilder: (context, state) {
                return S2Tile.fromState(
                  state,
                  isLoading: state1 is TagEnableStateLoadInProgress,
                );
              }
          );
      }
    );
  }
}