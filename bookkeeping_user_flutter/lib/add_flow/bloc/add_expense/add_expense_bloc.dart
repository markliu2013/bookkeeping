import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '/login/login.dart';
import '/flows/flows.dart';
import '/add_flow/add_flow.dart';
import '/accounts/accounts.dart';

part 'add_expense_event.dart';
part 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {

  AddExpenseBloc({
    required this.flowRepository,
    required this.authBloc,
    required this.accountExpenseableBloc,
  }) : super(const AddExpenseState()) {
    on<AddExpenseDefaultLoaded>(_onDefaultLoaded);
    on<AddExpenseAccountChanged>(_onAccountChanged);
    on<AddExpensePayeeChanged>(_onPayeeChanged);
    on<AddExpenseTagChanged>(_onTagChanged);
    on<AddExpenseDescriptionChanged>(_onDescriptionChanged);
    on<AddExpenseNotesChanged>(_onNotesChanged);
    on<AddExpenseCreateTimeChanged>(_onCreateTimeChanged);
    on<AddExpenseCreateDateChanged>(_onCreateDateChanged);
    on<AddExpenseCategoryChanged>(_onCategoryChanged);
    on<AddExpenseAmountChanged>(_onAmountChanged);
    on<AddExpenseConvertedAmountChanged>(_onConvertedAmountChanged);
    on<AddExpenseConfirmedChanged>(_onConfirmedChanged);
    on<AddExpenseSubmitted>(_onSubmitted);
  }

  final FlowRepository flowRepository;
  final AuthBloc authBloc;
  final AccountExpenseableBloc accountExpenseableBloc;

  void _onAccountChanged(AddExpenseAccountChanged event, Emitter<AddExpenseState> emit) {
    String? currencyCode = null;
    if (accountExpenseableBloc.state is AccountExpenseableStateLoadSuccess) {
      AccountExpenseableStateLoadSuccess state = accountExpenseableBloc.state as AccountExpenseableStateLoadSuccess;
      Account account = state.accounts.firstWhere((account) => account.id.toString() == event.accountId);
      currencyCode = account.currencyCode;
    }
    emit(state.copyWith(
      request: state.request.copyWith(accountId: event.accountId),
      currencyCode: currencyCode
    ));
  }

  void _onTagChanged(AddExpenseTagChanged event, Emitter<AddExpenseState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(tags: event.tags),
    ));
  }

  void _onDescriptionChanged(AddExpenseDescriptionChanged event, Emitter<AddExpenseState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(description: event.description),
    ));
  }

  void _onNotesChanged(AddExpenseNotesChanged event, Emitter<AddExpenseState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(notes: event.notes),
    ));
  }

  void _onConfirmedChanged(AddExpenseConfirmedChanged event, Emitter<AddExpenseState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(confirmed: event.confirmed),
    ));
  }

  void _onPayeeChanged(AddExpensePayeeChanged event, Emitter<AddExpenseState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(payeeId: event.payeeId),
    ));
  }

  void _onCreateTimeChanged(AddExpenseCreateTimeChanged event, Emitter<AddExpenseState> emit) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(state.request.createTime ?? DateTime.now().millisecondsSinceEpoch);
    dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day, event.time.hour, event.time.minute);
    emit(state.copyWith(
      request: state.request.copyWith(createTime: dateTime.millisecondsSinceEpoch),
    ));
  }

  void _onCreateDateChanged(AddExpenseCreateDateChanged event, Emitter<AddExpenseState> emit) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(state.request.createTime ?? DateTime.now().millisecondsSinceEpoch);
    dateTime = DateTime(event.dateTime.year, event.dateTime.month, event.dateTime.day, dateTime.hour, dateTime.minute);
    emit(state.copyWith(
      request: state.request.copyWith(createTime: dateTime.millisecondsSinceEpoch),
    ));
  }

  void _onCategoryChanged(AddExpenseCategoryChanged event, Emitter<AddExpenseState> emit) {
    final List fixedList = Iterable<int>.generate(event.categoryIds.length).toList();
    emit(state.copyWith(
      request: state.request.copyWith(
        categories: fixedList.map((i) {
          return new CategoryIdAmountRequest(amount: 0, convertedAmount: null, categoryId: event.categoryIds[i], categoryName: event.categoryNames[i]);
        }).toList(),
      ),
    ));
  }

  void _onAmountChanged(AddExpenseAmountChanged event, Emitter<AddExpenseState> emit) {
    state.request.categories?.firstWhere((item) => item.categoryId == event.categoryId).amount = num.tryParse(event.amount) ?? 0;
  }

  void _onConvertedAmountChanged(AddExpenseConvertedAmountChanged event, Emitter<AddExpenseState> emit) {
    state.request.categories?.firstWhere((item) => item.categoryId == event.categoryId).convertedAmount = num.tryParse(event.convertedAmount) ?? null;
  }

  void _onDefaultLoaded(AddExpenseDefaultLoaded event, Emitter<AddExpenseState> emit) {
    List<CategoryIdAmountRequest> defaultCategories = [];
    if (event.deal != null) {
      defaultCategories = event.deal!.categories.map((e) =>
        new CategoryIdAmountRequest(
          categoryId: e.categoryId.toString(),
          categoryName: e.categoryName,
          amount: event.type == 4 ? e.amount*-1 : e.amount,
          convertedAmount: event.type == 4 ? e.convertedAmount*-1 : e.convertedAmount
        )
      ).toList();
    } else if (authBloc.state.session!.defaultBook.defaultExpenseCategory != null) {
      defaultCategories = [
        new CategoryIdAmountRequest(
          categoryId: authBloc.state.session!.defaultBook.defaultExpenseCategory!.id.toString(),
          categoryName: authBloc.state.session!.defaultBook.defaultExpenseCategory!.name,
          amount: 0,
          convertedAmount: null
        )
      ];
    }
    String? accountId = event.deal?.account?.id.toString() ?? authBloc.state.session!.defaultBook.defaultExpenseAccount?.id.toString() ?? null;
    String? currencyCode = null;
    if (accountExpenseableBloc.state is AccountExpenseableStateLoadSuccess && accountId != null) {
      AccountExpenseableStateLoadSuccess state = accountExpenseableBloc.state as AccountExpenseableStateLoadSuccess;
      Account account = state.accounts.firstWhere((account) => account.id.toString() == accountId);
      currencyCode = account.currencyCode;
    }
    emit(state.copyWith(
      status: FormzStatus.pure,
      request: state.request.copyWith(
        description: event.deal?.description ?? '',
        accountId: accountId,
        payeeId: event.deal?.payee?.id.toString() ?? '',
        categories: defaultCategories,
        tags: event.deal?.tags?.map((e) => e.tagId.toString()).toList() ?? [],
        createTime: event.type != 2 ? DateTime.now().millisecondsSinceEpoch : event.deal!.createTime,
        notes: event.type == 2 ? event.deal?.notes ?? '' : '',
      ),
      currencyCode: currencyCode
    ));
  }

  void _onSubmitted(AddExpenseSubmitted event, Emitter<AddExpenseState> emit) async {
    try {
      bool result = false;
      // 1-新增，2-修改，3-复制，4-退款
      switch (event.type) {
        case 1:
        case 3:
          result = await flowRepository.saveExpense(state.request);
          break;
        case 2:
          result = await flowRepository.updateExpense(event.deal!.id, state.request);
          break;
        case 4:
          result = await flowRepository.refundExpense(event.deal!.id, state.request);
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