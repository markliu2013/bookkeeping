import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/commons/commons.dart';
import '/add_flow/add_flow.dart';

class IsConfirmSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      buildFormItem(
        "是否确认",
        BlocSelector<AddTransferBloc, AddTransferState, bool?>(
          selector: (state) => state.request.confirmed,
          builder: (context, state) {
            return
              Align(
                alignment: Alignment.centerLeft,
                child: Switch(
                  value: state ?? true,
                  onChanged: (value) => context.read<AddTransferBloc>().add(AddTransferConfirmedChanged(value)),
                ),
              );
          }
        ), context);
  }
}