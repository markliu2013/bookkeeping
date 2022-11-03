import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/components.dart';
import '/add_flow/add_flow.dart';

class AddIncomeDateTimeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddIncomeBloc, AddIncomeState, int?>(
      selector: (state) => state.request.createTime,
      builder: (context, state) {
        return DateTimeInput(
          initialTime: state,
          onDateChange: (value) {
            BlocProvider.of<AddIncomeBloc>(context).add(AddIncomeCreateDateChanged(value));
          },
          onTimeChange: (value) {
            BlocProvider.of<AddIncomeBloc>(context).add(AddIncomeCreateTimeChanged(value));
          },
        );
      }
    );
  }
}