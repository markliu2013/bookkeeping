import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/accounts/accounts.dart';

part 'account_transfer_to_able_event.dart';
part 'account_transfer_to_able_state.dart';

class AccountTransferToAbleBloc extends Bloc<AccountTransferToAbleEvent, AccountTransferToAbleState> {

  final AccountRepository accountRepository;

  AccountTransferToAbleBloc({
    required this.accountRepository
  }) : super(AccountTransferToAbleStateLoadInProgress()) {
    on<AccountTransferToAbleLoaded>(_onAccountTransferToAbleLoaded);
  }

  void _onAccountTransferToAbleLoaded(_, Emitter<AccountTransferToAbleState> emit) async {
    // 只加载一次数据
    if (state is AccountTransferToAbleStateLoadSuccess) return;
    try {
      emit(AccountTransferToAbleStateLoadInProgress());
      final accounts = await accountRepository.getTransferToAble();
      emit(AccountTransferToAbleStateLoadSuccess(accounts));
    } catch (_) {
      emit(AccountTransferToAbleStateLoadFailure());
    }
  }

}