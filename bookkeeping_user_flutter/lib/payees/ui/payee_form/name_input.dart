import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/commons.dart';
import '/payees/payees.dart';

class NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return
      buildFormItem(
          '名称',
          BlocBuilder<PayeeFormBloc, PayeeFormState>(
            buildWhen: (previous, current) => previous.request.name != current.request.name,
            builder: (context, state) {
              controller.value = TextEditingValue(
                text: state.request.name ?? '',
                selection: TextSelection.fromPosition(
                  TextPosition(offset: state.request.name?.length ?? 0),
                ),
              );
              return
                TextField(
                  controller: controller,
                  onChanged: (value) => context.read<PayeeFormBloc>().add(PayeeFormNameChanged(value)),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  ),
                );
            }
          ), context
      );
  }
}
