import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '/accounts/accounts.dart';
import '/flows/flows.dart';
import '/commons/commons.dart';

class AdjustBalanceForm extends StatefulWidget {

  final int type; // 1-新增，2-修改，3-复制，4-退款
  final Account? account;
  final AdjustBalance? adjustBalance;

  AdjustBalanceForm({
    required this.type,
    this.account,
    this.adjustBalance
  });

  @override
  State<AdjustBalanceForm> createState() => _AdjustBalanceFormState();
}

class _AdjustBalanceFormState extends State<AdjustBalanceForm> {

  @override
  void initState() {
    BlocProvider.of<AccountAdjustBalanceBloc>(context).add(AccountAdjustBalanceDefaultLoaded(widget.type, widget.adjustBalance));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountAdjustBalanceBloc, AccountAdjustBalanceState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          Message.success('操作成功');
          Navigator.of(context).pop();
          BlocProvider.of<FlowsBloc>(context).add(FlowsRefreshed());
          if (widget.type == 1) {
            BlocProvider.of<AccountFetchBloc>(context).add(AccountFetched());
            BlocProvider.of<AccountsBloc>(context).add(AccountsRefreshed());
          }
          // 如果是修改和退款，要刷新账单详情页
          if (widget.type == 2) {
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
                AdjustBlanceDateTimeInput(),
                SizedBox(height: 10),
                if (widget.type == 1) BalanceInput(currentBalance: widget.account!.balance),
                SizedBox(height: 10),
                NoteInput()
              ],
            ),
          )
      )
    );
  }

}