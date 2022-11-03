import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '/commons/commons.dart';
import '/accounts/accounts.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {

  final AccountRepository accountRepository;

  AccountsBloc({
    required this.accountRepository,
  }) : super(AccountsState()) {
    on<AccountsRefreshed>(_onRefreshed);
    on<AccountsLoadMore>(_onLoadMore);
    on<AccountsTabChanged>(_onTabChanged);
    on<AccountsSortChanged>(_onSortChanged);
    on<AccountDeleted>(_onDeleted);
    on<AccountToggled>(_onToggled);
  }

  void _onRefreshed(_, Emitter<AccountsState> emit) async {
    try {
      emit(state.copyWith(
        status: LoadDataStatus.progress,
        request: state.request.copyWith(page: 1),
      ));
      final accounts = await accountRepository.query(state.request);
      emit(state.copyWith(
        status: LoadDataStatus.success,
        accounts: accounts,
        request: state.request.copyWith(page: state.request.page + 1),
      ));
    } catch (_) {
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

  void _onLoadMore(_, Emitter<AccountsState> emit) async {
    try {
      emit(state.copyWith(loadMoreStatus: LoadDataStatus.progress));
      final accounts = await accountRepository.query(state.request);
      if (accounts.isNotEmpty) {
        emit(state.copyWith(
          request: state.request.copyWith(page: state.request.page + 1),
          accounts: List.of(state.accounts)..addAll(accounts),
          loadMoreStatus: LoadDataStatus.success,
        ));
      } else {
        emit(state.copyWith(loadMoreStatus: LoadDataStatus.empty));
      }
    } catch (_) {
      emit(state.copyWith(loadMoreStatus: LoadDataStatus.failure));
    }
  }

  void _onTabChanged(AccountsTabChanged event, Emitter<AccountsState> emit) async {
    emit(state.copyWith(
      request: state.request.copyWith(type: event.tab+1),
    ));
  }

  void _onSortChanged(AccountsSortChanged event, Emitter<AccountsState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(sort: event.sort),
    ));
  }

  void _onDeleted(AccountDeleted event, Emitter<AccountsState> emit) async {
    try {
      emit(state.copyWith(deleteStatus: LoadDataStatus.progress));
      final result = await accountRepository.delete(event.id);
      if (result) {
        emit(state.copyWith(deleteStatus: LoadDataStatus.success));
      } else {
        emit(state.copyWith(deleteStatus: LoadDataStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(deleteStatus: LoadDataStatus.failure));
    }
  }

  void _onToggled(AccountToggled event, Emitter<AccountsState> emit) async {
    try {
      emit(state.copyWith(toggleStatus: LoadDataStatus.progress));
      final result = await accountRepository.toggle(event.id);
      if (result) {
        emit(state.copyWith(toggleStatus: LoadDataStatus.success));
      } else {
        emit(state.copyWith(toggleStatus: LoadDataStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(toggleStatus: LoadDataStatus.failure));
    }
  }

}
