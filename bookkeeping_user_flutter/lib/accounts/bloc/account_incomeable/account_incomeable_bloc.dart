import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/accounts/accounts.dart';

part 'account_incomeable_event.dart';
part 'account_incomeable_state.dart';

class AccountIncomeableBloc extends Bloc<AccountIncomeableEvent, AccountIncomeableState> {

  final AccountRepository accountRepository;

  AccountIncomeableBloc({
    required this.accountRepository
  }) : super(AccountIncomeableStateLoadInProgress()) {
    on<AccountIncomeableLoaded>(_onAccountIncomeableLoaded);
  }

  void _onAccountIncomeableLoaded(_, Emitter<AccountIncomeableState> emit) async {
    // 只加载一次数据
    if (state is AccountIncomeableStateLoadSuccess) return;
    try {
      emit(AccountIncomeableStateLoadInProgress());
      final accounts = await accountRepository.getIncomeable();
      emit(AccountIncomeableStateLoadSuccess(accounts));
    } catch (_) {
      emit(AccountIncomeableStateLoadFailure());
    }
  }

}