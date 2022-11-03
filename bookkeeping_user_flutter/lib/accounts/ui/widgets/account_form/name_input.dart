import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/commons.dart';
import '/accounts/accounts.dart';

class NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return
      buildFormItem(
          '名称',
          BlocBuilder<AccountFormBloc, AccountFormState>(
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
                  onChanged: (value) => context.read<AccountFormBloc>().add(AccountFormNameChanged(value)),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  ),
                );
            }
          ), context
      );
  }
}
