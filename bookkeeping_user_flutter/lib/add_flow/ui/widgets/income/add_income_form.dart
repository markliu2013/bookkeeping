import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '/add_flow/add_flow.dart';
import '/flows/flows.dart';
import '/commons/commons.dart';

import 'widgets.dart';

class AddIncomeForm extends StatelessWidget {

  final int type; // 1-新增，2-修改，3-复制，4-退款
  AddIncomeForm({
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddIncomeBloc, AddIncomeState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          Message.success('操作成功');
          Navigator.of(context).pop();
          BlocProvider.of<FlowsBloc>(context).add(FlowsRefreshed());
          // 如果是修改，要刷新账单详情页
          if (type == 2 || type == 4) {
            BlocProvider.of<FlowFetchBloc>(context).add(FlowFetched());
          }
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              DescriptionInput(),
              SizedBox(height: 10),
              AddIncomeDateTimeInput(),
              AccountInput(),
              CategoryInput(),
              PayeeInput(),
              TagInput(),
              IsConfirmSwitch(),
              NotesInput(),
            ],
          ),
        ),
      )
    );
  }

}