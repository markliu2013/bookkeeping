import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/commons/commons.dart';
import '/add_flow/add_flow.dart';

class DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return
      buildFormItem(
        '描述',
        BlocSelector<AddExpenseBloc, AddExpenseState, String?>(
          selector: (state) => state.request.description,
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
                onChanged: (value) => context.read<AddExpenseBloc>().add(AddExpenseDescriptionChanged(value)),
                decoration: InputDecoration()
              );
          }
        ), context
      );
  }
}