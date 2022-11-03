import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import '/accounts/accounts.dart';
import '/flows/flows.dart';

part 'account_adjust_balance_event.dart';
part 'account_adjust_balance_state.dart';

class AccountAdjustBalanceBloc extends Bloc<AccountAdjustBalanceEvent, AccountAdjustBalanceState> {

  final AccountRepository accountRepository;

  AccountAdjustBalanceBloc({
    required this.accountRepository,
  }) : super(AccountAdjustBalanceState()) {
    on<AccountAdjustBalanceDescriptionChanged>(_onDescriptionChanged);
    on<AccountAdjustBalanceNotesChanged>(_onNotesChanged);
    on<AccountAdjustBalanceCreateDateChanged>(_onCreateDateChanged);
    on<AccountAdjustBalanceCreateTimeChanged>(_onCreateTimeChanged);
    on<AccountAdjustBalanceBalanceChanged>(_onBalanceChanged);
    on<AccountAdjustBalanceDefaultLoaded>(_onDefaultLoaded);
    on<AccountAdjustBalanceSubmitted>(_onSubmitted);
  }

  void _onDescriptionChanged(AccountAdjustBalanceDescriptionChanged event, Emitter<AccountAdjustBalanceState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(description: event.description),
    ));
  }

  void _onNotesChanged(AccountAdjustBalanceNotesChanged event, Emitter<AccountAdjustBalanceState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(notes: event.notes),
    ));
  }

  void _onCreateDateChanged(AccountAdjustBalanceCreateDateChanged event, Emitter<AccountAdjustBalanceState> emit) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(state.request.createTime ?? DateTime.now().millisecondsSinceEpoch);
    dateTime = DateTime(event.dateTime.year, event.dateTime.month, event.dateTime.day, dateTime.hour, dateTime.minute);
    emit(state.copyWith(
      request: state.request.copyWith(createTime: dateTime.millisecondsSinceEpoch),
    ));
  }

  void _onCreateTimeChanged(AccountAdjustBalanceCreateTimeChanged event, Emitter<AccountAdjustBalanceState> emit) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(state.request.createTime ?? DateTime.now().millisecondsSinceEpoch);
    dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day, event.time.hour, event.time.minute);
    emit(state.copyWith(
      request: state.request.copyWith(createTime: dateTime.millisecondsSinceEpoch),
    ));
  }

  void _onDefaultLoaded(AccountAdjustBalanceDefaultLoaded event, Emitter<AccountAdjustBalanceState> emit) {
    emit(state.copyWith(
        status: FormzStatus.pure,
        request: state.request.copyWith(
          description: event.adjustBalance?.description ?? '',
          createTime: event.type != 2 ? DateTime.now().millisecondsSinceEpoch : event.adjustBalance!.createTime,
          notes: event.adjustBalance?.notes ?? '',
        )
    ));
  }

  void _onBalanceChanged(AccountAdjustBalanceBalanceChanged event, Emitter<AccountAdjustBalanceState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(balance: event.balance),
    ));
  }

  void _onSubmitted(AccountAdjustBalanceSubmitted event, Emitter<AccountAdjustBalanceState> emit) async {
    try {
      bool result = false;
      switch (event.type) {
        case 1:
          result = await accountRepository.adjustBalance(event.accountId!, state.request);
          break;
        case 2:
          result = await accountRepository.updateAdjustBalance(event.adjustBalance!.id, state.request);
          break;
        default:
          break;
      }
      if (result) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

}
