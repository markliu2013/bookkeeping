import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/categories/categories.dart';
import '/commons/commons.dart';

class NotesInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return
      buildFormItem(
          '备注',
          BlocBuilder<CategoryFormBloc, CategoryFormState>(
              buildWhen: (previous, current) => previous.request.notes != current.request.notes,
              builder: (context, state) {
                controller.value = TextEditingValue(
                  text: state.request.notes ?? '',
                  selection: TextSelection.fromPosition(
                    TextPosition(offset: state.request.notes?.length ?? 0),
                  ),
                );
                return
                  TextField(
                    controller: controller,
                    onChanged: (value) => context.read<CategoryFormBloc>().add(CategoryFormNotesChanged(value)),
                    decoration: InputDecoration(),
                  );
              }
          ), context
      );
  }
}
