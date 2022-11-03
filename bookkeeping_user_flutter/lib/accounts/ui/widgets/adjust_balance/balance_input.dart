import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/commons/commons.dart';
import '/accounts/accounts.dart';

class BalanceInput extends StatelessWidget {

  final num currentBalance;

  BalanceInput({
    required this.currentBalance,
  });

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return Container(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('余额', style: Theme.of(context).textTheme.bodyText1),
          SizedBox(width: 10),
          Expanded(child: BlocSelector<AccountAdjustBalanceBloc, AccountAdjustBalanceState, String?>(
            selector: (state) => state.request.balance,
            builder: (context, state) {
              controller.value = TextEditingValue(
                text: state ?? '',
                selection: TextSelection.fromPosition(
                  TextPosition(offset: state?.length ?? 0),
                ),
              );
              return
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => context.read<AccountAdjustBalanceBloc>().add(AccountAdjustBalanceBalanceChanged(value)),
                  decoration: InputDecoration(
                    hintText: '必填项',
                  )
                );
            }
          )),
          Text('当前余额：${removeDecimalZero(currentBalance)}', style: Theme.of(context).textTheme.bodyText2),
        ]
      )
    );
  }

}