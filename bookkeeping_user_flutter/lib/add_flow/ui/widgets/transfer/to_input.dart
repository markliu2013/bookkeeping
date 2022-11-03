import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_select/awesome_select.dart';

import '/commons/commons.dart';
import '/accounts/accounts.dart';
import '/add_flow/add_flow.dart';

class ToInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state1 = context.watch<AccountTransferToAbleBloc>().state;
    return BlocSelector<AddTransferBloc, AddTransferState, String?>(
      selector: (state) => state.request.toId,
      builder: (context, state) {
        return
          SmartSelect<String>.single(
            key: Key(new DateTime.now().millisecondsSinceEpoch.toString()),
            title: '转入账户',
            selectedValue: state ?? '',
            onChange: (selected) {
              context.read<AddTransferBloc>().add(AddTransferToChanged(selected.value ?? ''));
            },
            choiceItems: state1 is AccountTransferToAbleStateLoadSuccess ? modelToChoice(state1.accounts) : [],
            choiceType: S2ChoiceType.chips,
            modalFilter: true,
            modalFilterAuto: true,
            tileBuilder: (context, state) {
              return S2Tile.fromState(
                state,
                isLoading: state1 is AccountTransferToAbleStateLoadInProgress,
                padding: EdgeInsets.zero,
              );
            }
          );
      }
    );
  }
}
