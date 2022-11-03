import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/tags/tags.dart';
import '/commons/commons.dart';

class TransferableSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      buildFormItem(
        "是否可转账",
        BlocSelector<TagFormBloc, TagFormState, bool?>(
          selector: (state) => state.request.transferable,
          builder: (context, state) {
            return
              Align(
                alignment: Alignment.centerLeft,
                child: Switch(
                  value: state ?? true,
                  onChanged: (value) => context.read<TagFormBloc>().add(TagFormTransferableChanged(value)),
                ),
              );
          }
        ), context);
  }
}