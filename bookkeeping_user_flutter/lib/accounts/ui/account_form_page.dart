import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '/components/components.dart';
import '/commons/commons.dart';
import '/accounts/accounts.dart';
import '/login/login.dart';

class AccountFormPage extends StatelessWidget {

  final int type; // 1-新增，2-修改
  final int accountType;
  final Account? account;

  const AccountFormPage({
    required this.type,
    required this.accountType,
    this.account,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccountFormBloc(
          accountRepository: RepositoryProvider.of<AccountRepository>(context),
          authBloc: BlocProvider.of<AuthBloc>(context),
        )..add(AccountFormDefaultLoaded(type, accountType, account)
      ),
      child: BlocListener<AccountFormBloc, AccountFormState>(
        listener: (context, state) {
          if (state.status == FormzStatus.submissionSuccess) {
            Message.success('操作成功');
            Navigator.of(context).pop();
            BlocProvider.of<AccountsBloc>(context).add(AccountsRefreshed());
            if (type == 2) {
              BlocProvider.of<AccountFetchBloc>(context).add(AccountFetched());
            }
          }
        },
        child: Builder(
          builder: (context) {
            switch (accountType) {
              case 1:
                return CheckingAccountFormPage(type: type, accountType: accountType, account: account);
              case 2:
                return CreditAccountFormPage(type: type, accountType: accountType, account: account);
              case 3:
                return DebtAccountFormPage(type: type, accountType: accountType, account: account);
              case 4:
                return AssetAccountFormPage(type: type, accountType: accountType, account: account);
              default:
                return PageError(msg: '账户类型错误');
            }
          },
        )
      )
    );
  }

}
