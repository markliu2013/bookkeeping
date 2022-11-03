import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_select/awesome_select.dart';
import '/commons/commons.dart';
import '/tags/tags.dart';

class ParentInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state1 = context.watch<TagEnableBloc>().state;
    return BlocBuilder<TagFormBloc, TagFormState>(
      buildWhen: (previous, current) => previous.request.parentId != current.request.parentId,
      builder: (context, state) {
        return SmartSelect<String>.single
          (
            title: '父级标签',
            selectedValue: state.request.parentId ?? '',
            onChange: (selected) {
              context.read<TagFormBloc>().add(TagFormParentChanged(selected.value ?? ''));
            },
            choiceItems: state1 is TagEnableStateLoadSuccess ? modelToChoice(state1.tags) : [],
            choiceType: S2ChoiceType.chips,
            modalFilter: true,
            modalFilterAuto: true,
            tileBuilder: (context, state) {
              return S2Tile.fromState(
                state,
                isLoading: state1 is TagEnableStateLoadInProgress,
                padding: EdgeInsets.zero,
              );
            }
        );
      }
    );
  }
}