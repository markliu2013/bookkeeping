import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/commons/commons.dart';
import '/add_flow/add_flow.dart';

class NotesInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return
      buildFormItem(
        '备注',
        BlocSelector<AddIncomeBloc, AddIncomeState, String?>(
          selector: (state) => state.request.notes,
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
                onChanged: (value) => context.read<AddIncomeBloc>().add(AddIncomeNotesChanged(value)),
                decoration: InputDecoration()
              );
          }
        ), context
      );
  }
}