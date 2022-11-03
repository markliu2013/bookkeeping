import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/components.dart';
import '/add_flow/add_flow.dart';

class AddExpenseDateTimeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddExpenseBloc, AddExpenseState, int?>(
      selector: (state) => state.request.createTime,
      builder: (context, state) {
        return DateTimeInput(
          initialTime: state,
          onDateChange: (value) {
            BlocProvider.of<AddExpenseBloc>(context).add(AddExpenseCreateDateChanged(value));
          },
          onTimeChange: (value) {
            BlocProvider.of<AddExpenseBloc>(context).add(AddExpenseCreateTimeChanged(value));
          },
        );
      }
    );
  }
}