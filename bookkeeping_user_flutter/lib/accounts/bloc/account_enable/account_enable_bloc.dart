import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/accounts/accounts.dart';

part 'account_enable_event.dart';
part 'account_enable_state.dart';

class AccountEnableBloc extends Bloc<AccountEnableEvent, AccountEnableState> {

  final AccountRepository accountRepository;

  AccountEnableBloc({
    required this.accountRepository
  }) : super(AccountEnableStateLoadInProgress()) {
    on<AccountEnableLoaded>(_onAccountEnableLoaded);
  }

  void _onAccountEnableLoaded(_, Emitter<AccountEnableState> emit) async {
    // 只加载一次数据
    if (state is AccountEnableStateLoadSuccess) return;
      emit(AccountEnableStateLoadInProgress());
      final accounts = await accountRepository.getEnable();
      emit(AccountEnableStateLoadSuccess(accounts));

  }

}