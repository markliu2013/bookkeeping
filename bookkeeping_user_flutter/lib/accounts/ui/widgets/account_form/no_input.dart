import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/accounts/accounts.dart';
import '/commons/commons.dart';

class NoInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return
      buildFormItem(
          '卡号',
          BlocBuilder<AccountFormBloc, AccountFormState>(
            buildWhen: (previous, current) => previous.request.no != current.request.no,
            builder: (context, state) {
              controller.value = TextEditingValue(
                text: state.request.no ?? '',
                selection: TextSelection.fromPosition(
                  TextPosition(offset: state.request.no?.length ?? 0),
                ),
              );
              return
                TextField(
                  controller: controller,
                  onChanged: (value) => context.read<AccountFormBloc>().add(AccountFormNoChanged(value)),
                  decoration: InputDecoration(),
                );
            }
          ), context
      );
  }
}
