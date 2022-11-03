import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/accounts/accounts.dart';

class AccountAdjustBalance extends StatelessWidget {

  final Account account;

  AccountAdjustBalance({
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('调整账户余额'),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                icon: Icon(Icons.done),
                onPressed: () {
                  BlocProvider.of<AccountAdjustBalanceBloc>(context).add(AccountAdjustBalanceSubmitted(1, account.id, null));
                }
              );
            })
          ]
      ),
      body: AdjustBalanceForm(type: 1, account: account),
    );
  }

}
