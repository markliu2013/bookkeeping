import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '/payees/payees.dart';
import '/commons/commons.dart';

class PayeeFormPage extends StatelessWidget {

  final int type; // 1-新增，2-修改
  final Payee? payee;

  const PayeeFormPage({
    required this.type,
    this.payee,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PayeeFormBloc(payeeRepository: RepositoryProvider.of<PayeeRepository>(context))..add(PayeeFormDefaultLoaded(type, payee)),
      child: BlocListener<PayeeFormBloc, PayeeFormState>(
        listener: (context, state) {
          if (state.status == FormzStatus.submissionSuccess) {
            Message.success('操作成功');
            Navigator.of(context).pop();
            BlocProvider.of<PayeesBloc>(context).add(PayeesRefreshed());
            if (type == 2) {
              BlocProvider.of<PayeeFetchBloc>(context).add(PayeeFetched());
            }
          }
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                  centerTitle: true,
                  title: Text(_buildTitle(type)),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.done),
                      onPressed: () {
                        BlocProvider.of<PayeeFormBloc>(context).add(PayeeFormSubmitted(type, payee));
                      }
                    )
                  ]
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      NameInput(),
                      SizedBox(height: 10),
                      ExpenseableSwitch(),
                      IncomeableSwitch(),
                      NotesInput()
                    ],
                  )
                )
              ),
            );
          }
        )

      )
    );
  }

  String _buildTitle(int type) {
    switch (type) {
      case 1:
        return '新增交易对象';
      case 2:
        return '修改交易对象';
      default:
        return '账户操作类型异常';
    }
  }

}
