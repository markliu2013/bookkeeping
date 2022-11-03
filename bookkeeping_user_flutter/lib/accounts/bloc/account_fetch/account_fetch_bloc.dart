import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '/accounts/accounts.dart';
import '/commons/commons.dart';

part 'account_fetch_event.dart';
part 'account_fetch_state.dart';

class AccountFetchBloc extends Bloc<AccountFetchEvent, AccountFetchState> {

  final AccountRepository accountRepository;

  AccountFetchBloc({
    required this.accountRepository,
  }) : super(AccountFetchState()) {
    on<AccountFetched>(_onFetched);
    on<AccountLoadDefault>(_onDefault);
  }

  void _onDefault(AccountLoadDefault event, Emitter<AccountFetchState> emit) {
    emit(state.copyWith(
      status: LoadDataStatus.success,
      account: event.account
    ));
  }

  void _onFetched(_, Emitter<AccountFetchState> emit) async {
    try {
      emit(state.copyWith(status: LoadDataStatus.progress));
      final account = await accountRepository.get(state.account!.id);
      emit(state.copyWith(
        status: LoadDataStatus.success,
        account: account,
      ));
    } catch (_) {
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

}
