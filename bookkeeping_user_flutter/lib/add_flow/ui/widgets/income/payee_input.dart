import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_select/awesome_select.dart';

import '/commons/commons.dart';
import '/add_flow/add_flow.dart';
import '/payees/payees.dart';

class PayeeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state1 = context.watch<PayeeIncomeableBloc>().state;
    return BlocSelector<AddIncomeBloc, AddIncomeState, String?>(
      selector: (state) => state.request.payeeId,
      builder: (context, state) {
        return
          SmartSelect<String>.single
          (
            key: Key(new DateTime.now().millisecondsSinceEpoch.toString()),
            title: '对象',
            selectedValue: state ?? '',
            onChange: (selected) {
              context.read<AddIncomeBloc>().add(AddIncomePayeeChanged(selected.value ?? ''));
            },
            choiceItems: state1 is PayeeIncomeableStateLoadSuccess ? modelToChoice(state1.payees) : [],
            choiceType: S2ChoiceType.chips,
            modalFilter: true,
            modalFilterAuto:true,
            tileBuilder: (context, state) {
              return S2Tile.fromState(
                state,
                isLoading: state1 is PayeeIncomeableStateLoadInProgress,
                padding: EdgeInsets.zero,
              );
            }
          );
        }
    );
  }
}