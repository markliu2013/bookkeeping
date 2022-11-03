import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_select/awesome_select.dart';

import '/commons/commons.dart';
import '/flows/flows.dart';
import '/payees/payees.dart';

class PayeeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state1 = context.watch<PayeeEnableBloc>().state;
    return BlocSelector<FlowsBloc, FlowsState, List<String>?>(
      selector: (state) => state.request.payees,
      builder: (context, state) {
        return
          SmartSelect<String>.single
            (
              title: '交易对象',
              selectedValue: state?.first ?? '',
              onChange: (selected) {
                context.read<FlowsBloc>().add(FlowsFilterPayeeChanged(selected.value ?? ''));
              },
              choiceItems: state1 is PayeeEnableStateLoadSuccess ? modelToChoice(state1.payees) : [],
              choiceType: S2ChoiceType.chips,
              modalFilter: true,
              modalFilterAuto:true,
              tileBuilder: (context, state) {
                return S2Tile.fromState(
                  state,
                  isLoading: state1 is PayeeEnableStateLoadInProgress,
                );
              }
          );
      }
    );
  }
}