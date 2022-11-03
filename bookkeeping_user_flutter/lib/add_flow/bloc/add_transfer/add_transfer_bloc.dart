import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '/login/login.dart';
import '/flows/flows.dart';
import '/add_flow/add_flow.dart';
import '/accounts/accounts.dart';

part 'add_transfer_event.dart';
part 'add_transfer_state.dart';

class AddTransferBloc extends Bloc<AddTransferEvent, AddTransferState> {

  AddTransferBloc({
    required this.flowRepository,
    required this.authBloc,
    required this.accountTransferFromAbleBloc,
    required this.accountTransferToAbleBloc,
  }) : super(const AddTransferState()) {
    on<AddTransferDefaultLoaded>(_onDefaultLoaded);
    on<AddTransferFromChanged>(_onFromChanged);
    on<AddTransferToChanged>(_onToChanged);
    on<AddTransferAmountChanged>(_onAmountChanged);
    on<AddTransferConvertedAmountChanged>(_onConvertedAmountChanged);
    on<AddTransferTagChanged>(_onTagChanged);
    on<AddTransferDescriptionChanged>(_onDescriptionChanged);
    on<AddTransferNotesChanged>(_onNotesChanged);
    on<AddTransferCreateTimeChanged>(_onCreateTimeChanged);
    on<AddTransferCreateDateChanged>(_onCreateDateChanged);
    on<AddTransferConfirmedChanged>(_onConfirmedChanged);
    on<AddTransferSubmitted>(_onSubmitted);
  }

  final FlowRepository flowRepository;
  final AuthBloc authBloc;
  final AccountTransferFromAbleBloc accountTransferFromAbleBloc;
  final AccountTransferToAbleBloc accountTransferToAbleBloc;

  void _onFromChanged(AddTransferFromChanged event, Emitter<AddTransferState> emit) {
    String? fromCurrencyCode = null;
    if (accountTransferFromAbleBloc.state is AccountTransferFromAbleStateLoadSuccess) {
      AccountTransferFromAbleStateLoadSuccess state = accountTransferFromAbleBloc.state as AccountTransferFromAbleStateLoadSuccess;
      Account account = state.accounts.firstWhere((account) => account.id.toString() == event.fromId);
      fromCurrencyCode = account.currencyCode;
    }
    emit(state.copyWith(
      request: state.request.copyWith(fromId: event.fromId),
      fromCurrencyCode: fromCurrencyCode
    ));
  }

  void _onToChanged(AddTransferToChanged event, Emitter<AddTransferState> emit) {
    String? toCurrencyCode = null;
    if (accountTransferToAbleBloc.state is AccountTransferToAbleStateLoadSuccess) {
      AccountTransferToAbleStateLoadSuccess state = accountTransferToAbleBloc.state as AccountTransferToAbleStateLoadSuccess;
      Account account = state.accounts.firstWhere((account) => account.id.toString() == event.toId);
      toCurrencyCode = account.currencyCode;
    }
    emit(state.copyWith(
      request: state.request.copyWith(toId: event.toId),
      toCurrencyCode: toCurrencyCode
    ));
  }

  void _onTagChanged(AddTransferTagChanged event, Emitter<AddTransferState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(tags: event.tags),
    ));
  }

  void _onDescriptionChanged(AddTransferDescriptionChanged event, Emitter<AddTransferState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(description: event.description),
    ));
  }

  void _onNotesChanged(AddTransferNotesChanged event, Emitter<AddTransferState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(notes: event.notes),
    ));
  }

  void _onConfirmedChanged(AddTransferConfirmedChanged event, Emitter<AddTransferState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(confirmed: event.confirmed),
    ));
  }

  void _onCreateTimeChanged(AddTransferCreateTimeChanged event, Emitter<AddTransferState> emit) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(state.request.createTime ?? DateTime.now().millisecondsSinceEpoch);
    dateTime = new DateTime(dateTime.year, dateTime.month, dateTime.day, event.time.hour, event.time.minute);
    emit(state.copyWith(
      request: state.request.copyWith(createTime: dateTime.millisecondsSinceEpoch),
    ));
  }

  void _onCreateDateChanged(AddTransferCreateDateChanged event, Emitter<AddTransferState> emit) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(state.request.createTime ?? DateTime.now().millisecondsSinceEpoch);
    dateTime = new DateTime(event.dateTime.year, event.dateTime.month, event.dateTime.day, dateTime.hour, dateTime.minute);
    emit(state.copyWith(
      request: state.request.copyWith(createTime: dateTime.millisecondsSinceEpoch),
    ));
  }

  void _onAmountChanged(AddTransferAmountChanged event, Emitter<AddTransferState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(amount: num.tryParse(event.amount) ?? 0),
    ));
  }

  void _onConvertedAmountChanged(AddTransferConvertedAmountChanged event, Emitter<AddTransferState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(convertedAmount: num.tryParse(event.convertedAmount) ?? null),
    ));
  }

  void _onDefaultLoaded(AddTransferDefaultLoaded event, Emitter<AddTransferState> emit) {
    String? fromId = event.transfer?.from.id.toString() ?? authBloc.state.session!.defaultBook.defaultTransferFromAccount?.id.toString() ?? null;
    String? fromCurrencyCode = null;
    if (accountTransferFromAbleBloc.state is AccountTransferFromAbleStateLoadSuccess && fromId != null) {
      AccountTransferFromAbleStateLoadSuccess state = accountTransferFromAbleBloc.state as AccountTransferFromAbleStateLoadSuccess;
      Account account = state.accounts.firstWhere((account) => account.id.toString() == fromId);
      fromCurrencyCode = account.currencyCode;
    }
    String? toId = event.transfer?.to.id.toString() ?? authBloc.state.session!.defaultBook.defaultTransferToAccount?.id.toString() ?? null;
    String? toCurrencyCode = null;
    if (accountTransferToAbleBloc.state is AccountTransferToAbleStateLoadSuccess && toId != null) {
      AccountTransferToAbleStateLoadSuccess state = accountTransferToAbleBloc.state as AccountTransferToAbleStateLoadSuccess;
      Account account = state.accounts.firstWhere((account) => account.id.toString() == toId);
      toCurrencyCode = account.currencyCode;
    }
    emit(state.copyWith(
      status: FormzStatus.pure,
      request: state.request.copyWith(
        description: event.transfer?.description ?? '',
        fromId: event.transfer?.from.id.toString() ?? authBloc.state.session!.defaultBook.defaultTransferFromAccount?.id.toString() ?? '',
        toId: event.transfer?.to.id.toString() ?? authBloc.state.session!.defaultBook.defaultTransferToAccount?.id.toString() ?? '',
        amount: event.transfer?.amount,
        convertedAmount: event.transfer?.convertedAmount,
        tags: event.transfer?.tags?.map((e) => e.tagId.toString()).toList() ?? [],
        createTime: event.type != 2 ? DateTime.now().millisecondsSinceEpoch : event.transfer!.createTime,
        notes: event.type == 2 ? event.transfer?.notes ?? '' : '',
      ),
      fromCurrencyCode: fromCurrencyCode,
      toCurrencyCode: toCurrencyCode
    ));
  }

  void _onSubmitted(AddTransferSubmitted event, Emitter<AddTransferState> emit) async {
    try {
      bool result = false;
      // 1-新增，2-修改，3-复制，4-退款
      switch (event.type) {
        case 1:
        case 3:
          result = await flowRepository.saveTransfer(state.request);
          break;
        case 2:
          result = await flowRepository.updateTransfer(event.transfer!.id, state.request);
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
      print(_);
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

}