import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_select/awesome_select.dart';

import '/commons/commons.dart';
import '/accounts/accounts.dart';
import '/add_flow/add_flow.dart';

class AccountInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state1 = context.watch<AccountExpenseableBloc>().state;
    return BlocSelector<AddExpenseBloc, AddExpenseState, String?>(
      selector: (state) => state.request.accountId,
      builder: (context, state) {
        return
          SmartSelect<String>.single(
            key: Key(new DateTime.now().millisecondsSinceEpoch.toString()),
            title: '账户',
            selectedValue: state ?? '',
            onChange: (selected) {
              context.read<AddExpenseBloc>().add(AddExpenseAccountChanged(selected.value ?? ''));
            },
            choiceItems: state1 is AccountExpenseableStateLoadSuccess ? modelToChoice(state1.accounts) : [],
            choiceType: S2ChoiceType.chips,
            modalFilter: true,
            modalFilterAuto: true,
            tileBuilder: (context, state) {
              return S2Tile.fromState(
                state,
                isLoading: state1 is AccountExpenseableStateLoadInProgress,
                padding: EdgeInsets.zero,
              );
            }
          );
      }
    );
  }
}
