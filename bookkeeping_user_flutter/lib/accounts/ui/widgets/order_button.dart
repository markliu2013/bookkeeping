import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/components.dart';
import '/accounts/accounts.dart';

class OrderButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountsBloc, AccountsState, String>(
        selector: (state) => state.request.sort,
        builder: (context, state) {
          return PopupMenu(
            onSelected: (selected) {
              if (selected != state) {
                context.read<AccountsBloc>().add(AccountsSortChanged(selected));
                context.read<AccountsBloc>().add(AccountsRefreshed());
              }
            },
            items: {
              'balance,desc': '按余额排序',
              'enable,desc': '可用优先',
              'expenseable,desc': '支出优先',
              'incomeable,desc': '收入优先',
            },
            selected: state,
          );
        }
    );
  }

}