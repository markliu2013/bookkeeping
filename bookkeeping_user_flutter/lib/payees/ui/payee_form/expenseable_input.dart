import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/payees/payees.dart';
import '/commons/commons.dart';

class ExpenseableSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      buildFormItem(
        "是否可支出",
        BlocSelector<PayeeFormBloc, PayeeFormState, bool?>(
          selector: (state) => state.request.expenseable,
          builder: (context, state) {
            return
              Align(
                alignment: Alignment.centerLeft,
                child: Switch(
                  value: state ?? true,
                  onChanged: (value) => context.read<PayeeFormBloc>().add(PayeeFormExpenseableChanged(value)),
                ),
              );
          }
        ), context);
  }
}