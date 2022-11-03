import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_select/awesome_select.dart';

import '/flows/flows.dart';

class StatusInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<S2Choice<String>> options = [
      S2Choice<String>(value: '1', title: '正常'),
      S2Choice<String>(value: '2', title: '待确认'),
      S2Choice<String>(value: '3', title: '已退款'),
    ];
    return BlocSelector<FlowsBloc, FlowsState, String?>(
      selector: (state) => state.request.status,
      builder: (context, state) {
        return
          SmartSelect<String>.single
            (
              title: '交易状态',
              selectedValue: state ?? '',
              onChange: (selected) {
                context.read<FlowsBloc>().add(FlowsFilterStatusChanged(selected.value ?? ''));
              },
              choiceItems: options,
              choiceType: S2ChoiceType.radios,
          );
      }
    );
  }
}