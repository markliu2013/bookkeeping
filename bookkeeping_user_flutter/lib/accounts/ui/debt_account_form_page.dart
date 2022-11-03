import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/accounts/accounts.dart';
import '/login/login.dart';

class DebtAccountFormPage extends StatelessWidget {

  final int type; // 1-新增，2-修改
  final int accountType;
  final Account? account;

  const DebtAccountFormPage({
    required this.type,
    required this.accountType,
    this.account
  });

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final state = context.watch<AccountFormBloc>().state;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(_buildTitle(type)),
          actions: [
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                BlocProvider.of<AccountFormBloc>(context).add(AccountFormSubmitted(type, accountType, account));
              }
            )
          ]
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              if (type == 1) CurrencyInput(),
              NameInput(),
              if (type == 1) SizedBox(height: 10),
              if (type == 1) AccountBalanceInput(),
              if (type == 1) SizedBox(height: 10),
              AccountLimitInput(),
              SizedBox(height: 10),
              AccountAprInput(),
              SizedBox(height: 10),
              NoInput(),
              SizedBox(height: 10),
              ExpenseableSwitch(),
              SizedBox(height: 10),
              IncomeableSwitch(),
              SizedBox(height: 10),
              TransferFromAbleSwitch(),
              SizedBox(height: 10),
              TransferToAbleSwitch(),
              SizedBox(height: 10),
              IncludeSwitch(),
              SizedBox(height: 10),
              NotesInput()
            ],
          ),
        ),
      )
    );
  }

  String _buildTitle(int type) {
    switch (type) {
      case 1:
        return '新增贷款账户';
      case 2:
        return '修改贷款账户';
      default:
        return '账户操作类型异常';
    }
  }

}
