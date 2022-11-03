import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/accounts/accounts.dart';

part 'account_transfer_from_able_event.dart';
part 'account_transfer_from_able_state.dart';

class AccountTransferFromAbleBloc extends Bloc<AccountTransferFromAbleEvent, AccountTransferFromAbleState> {

  final AccountRepository accountRepository;

  AccountTransferFromAbleBloc({
    required this.accountRepository
  }) : super(AccountTransferFromAbleStateLoadInProgress()) {
    on<AccountTransferFromAbleLoaded>(_onAccountTransferFromAbleLoaded);
  }

  void _onAccountTransferFromAbleLoaded(_, Emitter<AccountTransferFromAbleState> emit) async {
    // 只加载一次数据
    if (state is AccountTransferFromAbleStateLoadSuccess) return;
    try {
      emit(AccountTransferFromAbleStateLoadInProgress());
      final accounts = await accountRepository.getTransferFromAble();
      emit(AccountTransferFromAbleStateLoadSuccess(accounts));
    } catch (_) {
      emit(AccountTransferFromAbleStateLoadFailure());
    }
  }

}