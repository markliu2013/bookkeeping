import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_select/awesome_select.dart';

import '/commons/commons.dart';
import '/flows/flows.dart';
import '/accounts/accounts.dart';

class AccountInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state1 = context.watch<AccountEnableBloc>().state;
    return BlocSelector<FlowsBloc, FlowsState, String?>(
      selector: (state) => state.request.accountId,
      builder: (context, state) {
        return
          SmartSelect<String>.single(
            title: '交易账户',
            selectedValue: state ?? '',
            onChange: (selected) {
              context.read<FlowsBloc>().add(FlowsFilterAccountIdChanged(selected.value ?? ''));
            },
            choiceItems: state1 is AccountEnableStateLoadSuccess ? modelToChoice(state1.accounts) : [],
            choiceType: S2ChoiceType.chips,
            modalFilter: true,
            modalFilterAuto: true,
            tileBuilder: (context, state) {
              return S2Tile.fromState(
                state,
                isLoading: state1 is AccountExpenseableStateLoadInProgress,
              );
            }
          );
      }
    );
  }
}
