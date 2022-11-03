import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_select/awesome_select.dart';

import '/flows/flows.dart';

class TypeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<S2Choice<String>> options = [
      S2Choice<String>(value: '1', title: '支出'),
      S2Choice<String>(value: '2', title: '收入'),
      S2Choice<String>(value: '3', title: '转账'),
      S2Choice<String>(value: '4', title: '余额调整'),
    ];
    return BlocSelector<FlowsBloc, FlowsState, String?>(
      selector: (state) => state.request.type,
      builder: (context, state) {
        return
          SmartSelect<String>.single
            (
              title: '交易类型',
              selectedValue: state ?? '',
              onChange: (selected) {
                context.read<FlowsBloc>().add(FlowsFilterTypeChanged(selected.value ?? ''));
              },
              choiceItems: options,
              choiceType: S2ChoiceType.radios,
          );
      }
    );
  }
}