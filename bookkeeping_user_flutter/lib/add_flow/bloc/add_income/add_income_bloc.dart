import 'package:bookkeeping_user_flutter/accounts/accounts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '/login/login.dart';
import '/flows/flows.dart';
import '../models/deal_add_request.dart';

part 'add_income_event.dart';
part 'add_income_state.dart';

class AddIncomeBloc extends Bloc<AddIncomeEvent, AddIncomeState> {

  AddIncomeBloc({
    required this.flowRepository,
    required this.authBloc,
    required this.accountIncomeableBloc
  }) : super(const AddIncomeState()) {
    on<AddIncomeDefaultLoaded>(_onDefaultLoaded);
    on<AddIncomeAccountChanged>(_onAccountChanged);
    on<AddIncomePayeeChanged>(_onPayeeChanged);
    on<AddIncomeTagChanged>(_onTagChanged);
    on<AddIncomeDescriptionChanged>(_onDescriptionChanged);
    on<AddIncomeNotesChanged>(_onNotesChanged);
    on<AddIncomeCreateTimeChanged>(_onCreateTimeChanged);
    on<AddIncomeCreateDateChanged>(_onCreateDateChanged);
    on<AddIncomeCategoryChanged>(_onCategoryChanged);
    on<AddIncomeAmountChanged>(_onAmountChanged);
    on<AddIncomeConvertedAmountChanged>(_onConvertedAmountChanged);
    on<AddIncomeConfirmedChanged>(_onConfirmedChanged);
    on<AddIncomeSubmitted>(_onSubmitted);
  }

  final FlowRepository flowRepository;
  final AuthBloc authBloc;
  final AccountIncomeableBloc accountIncomeableBloc;

  void _onAccountChanged(AddIncomeAccountChanged event, Emitter<AddIncomeState> emit) {
    String? currencyCode = null;
    if (accountIncomeableBloc.state is AccountIncomeableStateLoadSuccess) {
      AccountIncomeableStateLoadSuccess state = accountIncomeableBloc.state as AccountIncomeableStateLoadSuccess;
      Account account = state.accounts.firstWhere((account) => account.id.toString() == event.accountId);
      currencyCode = account.currencyCode;
    }
    emit(state.copyWith(
        request: state.request.copyWith(accountId: event.accountId),
        currencyCode: currencyCode
    ));
  }

  void _onTagChanged(AddIncomeTagChanged event, Emitter<AddIncomeState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(tags: event.tags),
    ));
  }

  void _onDescriptionChanged(AddIncomeDescriptionChanged event, Emitter<AddIncomeState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(description: event.description),
    ));
  }

  void _onNotesChanged(AddIncomeNotesChanged event, Emitter<AddIncomeState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(notes: event.notes),
    ));
  }

  void _onConfirmedChanged(AddIncomeConfirmedChanged event, Emitter<AddIncomeState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(confirmed: event.confirmed),
    ));
  }

  void _onPayeeChanged(AddIncomePayeeChanged event, Emitter<AddIncomeState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(payeeId: event.payeeId),
    ));
  }

  void _onCreateTimeChanged(AddIncomeCreateTimeChanged event, Emitter<AddIncomeState> emit) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(state.request.createTime ?? DateTime.now().millisecondsSinceEpoch);
    dateTime = new DateTime(dateTime.year, dateTime.month, dateTime.day, event.time.hour, event.time.minute);
    emit(state.copyWith(
      request: state.request.copyWith(createTime: dateTime.millisecondsSinceEpoch),
    ));
  }

  void _onCreateDateChanged(AddIncomeCreateDateChanged event, Emitter<AddIncomeState> emit) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(state.request.createTime ?? DateTime.now().millisecondsSinceEpoch);
    dateTime = new DateTime(event.dateTime.year, event.dateTime.month, event.dateTime.day, dateTime.hour, dateTime.minute);
    emit(state.copyWith(
      request: state.request.copyWith(createTime: dateTime.millisecondsSinceEpoch),
    ));
  }

  void _onCategoryChanged(AddIncomeCategoryChanged event, Emitter<AddIncomeState> emit) {
    final List fixedList = Iterable<int>.generate(event.categoryIds.length).toList();
    emit(state.copyWith(
      request: state.request.copyWith(
        categories: fixedList.map((i) {
          return new CategoryIdAmountRequest(amount: 0, convertedAmount: null, categoryId: event.categoryIds[i], categoryName: event.categoryNames[i]);
        }).toList(),
      ),
    ));
  }

  void _onAmountChanged(AddIncomeAmountChanged event, Emitter<AddIncomeState> emit) {
    state.request.categories?.firstWhere((item) => item.categoryId == event.categoryId).amount = num.tryParse(event.amount) ?? 0;
  }

  void _onConvertedAmountChanged(AddIncomeConvertedAmountChanged event, Emitter<AddIncomeState> emit) {
    state.request.categories?.firstWhere((item) => item.categoryId == event.categoryId).convertedAmount = num.tryParse(event.convertedAmount) ?? null;
  }

  void _onDefaultLoaded(AddIncomeDefaultLoaded event, Emitter<AddIncomeState> emit) {
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
    } else if (authBloc.state.session!.defaultBook.defaultIncomeCategory != null) {
      defaultCategories = [
        new CategoryIdAmountRequest(
          categoryId: authBloc.state.session!.defaultBook.defaultIncomeCategory!.id.toString(),
          categoryName: authBloc.state.session!.defaultBook.defaultIncomeCategory!.name,
          amount: 0,
          convertedAmount: null
        )
      ];
    }
    String? accountId = event.deal?.account?.id.toString() ?? authBloc.state.session!.defaultBook.defaultIncomeAccount?.id.toString() ?? null;
    String? currencyCode = null;
    if (accountIncomeableBloc.state is AccountIncomeableStateLoadSuccess && accountId != null) {
      AccountIncomeableStateLoadSuccess state = accountIncomeableBloc.state as AccountIncomeableStateLoadSuccess;
      Account account = state.accounts.firstWhere((account) => account.id.toString() == accountId);
      currencyCode = account.currencyCode;
    }
    emit(state.copyWith(
      status: FormzStatus.pure,
      request: state.request.copyWith(
        description: event.deal?.description ?? '',
        accountId: event.deal?.account?.id.toString() ?? authBloc.state.session!.defaultBook.defaultIncomeAccount?.id.toString() ?? '',
        payeeId: event.deal?.payee?.id.toString() ?? '',
        categories: defaultCategories,
        tags: event.deal?.tags?.map((e) => e.tagId.toString()).toList() ?? [],
        createTime: event.type != 2 ? DateTime.now().millisecondsSinceEpoch : event.deal!.createTime,
        notes: event.type == 2 ? event.deal?.notes ?? '' : '',
      ),
      currencyCode: currencyCode
    ));
  }

  void _onSubmitted(AddIncomeSubmitted event, Emitter<AddIncomeState> emit) async {
    try {
      bool result = false;
      // 1-新增，2-修改，3-复制，4-退款
      switch (event.type) {
        case 1:
        case 3:
          result = await flowRepository.saveIncome(state.request);
          break;
        case 2:
          result = await flowRepository.updateIncome(event.deal!.id, state.request);
          break;
        case 4:
          result = await flowRepository.refundIncome(event.deal!.id, state.request);
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