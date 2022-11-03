import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/accounts/accounts.dart';

part 'account_expenseable_event.dart';
part 'account_expenseable_state.dart';

class AccountExpenseableBloc extends Bloc<AccountExpenseableEvent, AccountExpenseableState> {

  final AccountRepository accountRepository;

  AccountExpenseableBloc({
    required this.accountRepository
  }) : super(AccountExpenseableStateLoadInProgress()) {
    on<AccountExpenseableLoaded>(_onAccountExpenseableLoaded);
  }

  void _onAccountExpenseableLoaded(_, Emitter<AccountExpenseableState> emit) async {
    // 只加载一次数据
    if (state is AccountExpenseableStateLoadSuccess) return;
    try {
      emit(AccountExpenseableStateLoadInProgress());
      final accounts = await accountRepository.getExpenseable();
      emit(AccountExpenseableStateLoadSuccess(accounts));
    } catch (_) {
      print(_);
      emit(AccountExpenseableStateLoadFailure());
    }
  }

}