import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/commons.dart';
import '/items/items.dart';

class TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      buildFormItem(
          '标题',
          BlocBuilder<ItemFormBloc, ItemFormState>(
            buildWhen: (previous, current) => previous.title != current.title,
            builder: (context, state) {
              return
                TextField(
                  onChanged: (value) => context.read<ItemFormBloc>().add(ItemFormTitleChanged(value)),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    errorText: state.title.invalid ? '请输入标题' : null,
                  ),
                );
            }
          ), context
      );
  }
}
