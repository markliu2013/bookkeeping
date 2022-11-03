import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/components.dart';
import '/add_flow/add_flow.dart';

class AddTransferDateTimeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddTransferBloc, AddTransferState, int?>(
      selector: (state) => state.request.createTime,
      builder: (context, state) {
        return DateTimeInput(
          initialTime: state,
          onDateChange: (value) {
            BlocProvider.of<AddTransferBloc>(context).add(AddTransferCreateDateChanged(value));
          },
          onTimeChange: (value) {
            BlocProvider.of<AddTransferBloc>(context).add(AddTransferCreateTimeChanged(value));
          },
        );
      }
    );
  }
}