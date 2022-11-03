import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/components.dart';
import '/flows/flows.dart';

class OrderButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FlowsBloc, FlowsState, String>(
      selector: (state) => state.request.sort,
      builder: (context, state) {
        return PopupMenu(
          onSelected: (selected) {
            if (selected != state) {
              context.read<FlowsBloc>().add(FlowsSortChanged(selected));
              context.read<FlowsBloc>().add(FlowsRefreshed());
            }
          },
          items: {
            'createTime,desc': '按时间排序',
            'amount,desc': '按金额排序',
          },
          selected: state,
        );
      }
    );
  }

}