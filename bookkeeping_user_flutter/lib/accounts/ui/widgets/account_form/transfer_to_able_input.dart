import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/accounts/accounts.dart';
import '/commons/commons.dart';

class TransferToAbleSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      buildFormItem(
        "是否可转出",
        BlocSelector<AccountFormBloc, AccountFormState, bool?>(
          selector: (state) => state.request.transferToAble,
          builder: (context, state) {
            return
              Align(
                alignment: Alignment.centerLeft,
                child: Switch(
                  value: state ?? true,
                  onChanged: (value) => context.read<AccountFormBloc>().add(AccountFormTransferToAbleChanged(value)),
                ),
              );
          }
        ), context);
  }
}