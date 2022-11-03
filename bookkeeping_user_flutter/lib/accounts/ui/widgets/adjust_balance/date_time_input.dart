import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/components.dart';
import '/accounts/accounts.dart';

class AdjustBlanceDateTimeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountAdjustBalanceBloc, AccountAdjustBalanceState, int?>(
      selector: (state) => state.request.createTime,
      builder: (context, state) {
        return DateTimeInput(
          initialTime: state,
          onDateChange: (value) {
            BlocProvider.of<AccountAdjustBalanceBloc>(context).add(AccountAdjustBalanceCreateDateChanged(value));
          },
          onTimeChange: (value) {
            BlocProvider.of<AccountAdjustBalanceBloc>(context).add(AccountAdjustBalanceCreateTimeChanged(value));
          },
        );
      }
    );
  }
}