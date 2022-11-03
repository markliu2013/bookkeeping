import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/commons/commons.dart';
import '/add_flow/add_flow.dart';

class AmountInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return
      buildFormItem(
        '金额',
        BlocSelector<AddTransferBloc, AddTransferState, num?>(
          selector: (state) => state.request.amount,
          builder: (context, state) {
            controller.value = TextEditingValue(
              text: state != null && state != 0 ? removeDecimalZero(state) : '',
              selection: TextSelection.fromPosition(
                TextPosition(offset: state.toString().length),
              ),
            );
            return
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                onChanged: (value) => context.read<AddTransferBloc>().add(AddTransferAmountChanged(value)),
                decoration: InputDecoration()
              );
          }
        ), context
      );
  }
}