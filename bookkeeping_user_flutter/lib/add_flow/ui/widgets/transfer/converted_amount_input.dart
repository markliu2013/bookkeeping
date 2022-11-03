import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/commons/commons.dart';
import '/add_flow/add_flow.dart';

class ConvertedAmountInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    final state = context.watch<AddTransferBloc>().state;
    return
      buildFormItem(
        '折合${state.toCurrencyCode}',
        BlocSelector<AddTransferBloc, AddTransferState, num?>(
          selector: (state) => state.request.convertedAmount,
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
                onChanged: (value) => context.read<AddTransferBloc>().add(AddTransferConvertedAmountChanged(value)),
                decoration: InputDecoration()
              );
          }
        ), context
      );
  }
}