import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_select/awesome_select.dart';

import '/commons/commons.dart';
import '/accounts/accounts.dart';
import '/currency/currency.dart';

class CurrencyInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state1 = context.watch<CurrencyAllBloc>().state;
    return BlocSelector<AccountFormBloc, AccountFormState, String?>(
        selector: (state) => state.request.currencyCode,
        builder: (context, state) {
          return
            SmartSelect<String>.single(
                key: Key(new DateTime.now().millisecondsSinceEpoch.toString()),
                title: '币种',
                selectedValue: state ?? '',
                onChange: (selected) {
                  context.read<AccountFormBloc>().add(AccountFormCurrencyCodeChanged(selected.value ?? ''));
                },
                choiceItems: state1 is CurrencyAllStateLoadSuccess ? modelToChoiceCode(state1.currencies) : [],
                choiceType: S2ChoiceType.chips,
                modalFilter: true,
                modalFilterAuto: true,
                tileBuilder: (context, state) {
                  return S2Tile.fromState(
                    state,
                    isLoading: state1 is CurrencyAllStateLoadInProgress,
                    padding: EdgeInsets.zero,
                  );
                }
            );
        }
    );
  }
}
