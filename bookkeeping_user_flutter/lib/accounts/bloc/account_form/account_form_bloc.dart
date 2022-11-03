import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import '/commons/commons.dart';
import '/login/login.dart';
import '/accounts/accounts.dart';

part 'account_form_event.dart';
part 'account_form_state.dart';

class AccountFormBloc extends Bloc<AccountFormEvent, AccountFormState> {

  final AccountRepository accountRepository;
  final AuthBloc authBloc;

  AccountFormBloc({
    required this.accountRepository,
    required this.authBloc,
  }) : super(const AccountFormState()) {
    on<AccountFormCurrencyCodeChanged>(_onCurrencyCodeChanged);
    on<AccountFormNameChanged>(_onNameChanged);
    on<AccountFormBalanceChanged>(_onBalanceChanged);
    on<AccountFormNoChanged>(_onNoChanged);
    on<AccountFormExpenseableChanged>(_onExpenseableChanged);
    on<AccountFormIncomeableChanged>(_onIncomeableChanged);
    on<AccountFormTransferFromAbleChanged>(_onTransferFromAbleChanged);
    on<AccountFormTransferToAbleChanged>(_onTransferToAbleChanged);
    on<AccountFormIncludeChanged>(_onIncludeChanged);
    on<AccountFormNotesChanged>(_onNotesChanged);
    on<AccountFormLimitChanged>(_onLimitChanged);
    on<AccountFormBillDayChanged>(_onBillDayChanged);
    on<AccountFormAprChanged>(_onAprChanged);
    on<AccountFormSubmitted>(_onSubmitted);
    on<AccountFormDefaultLoaded>(_onDefaultLoaded);
  }

  void _onCurrencyCodeChanged(AccountFormCurrencyCodeChanged event, Emitter<AccountFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(currencyCode: event.currencyCode),
    ));
  }

  void _onNameChanged(AccountFormNameChanged event, Emitter<AccountFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(name: event.name),
    ));
  }

  void _onBalanceChanged(AccountFormBalanceChanged event, Emitter<AccountFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(balance: event.balance),
    ));
  }

  void _onNoChanged(AccountFormNoChanged event, Emitter<AccountFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(no: event.no),
    ));
  }

  void _onExpenseableChanged(AccountFormExpenseableChanged event, Emitter<AccountFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(expenseable: event.expenseable),
    ));
  }

  void _onIncomeableChanged(AccountFormIncomeableChanged event, Emitter<AccountFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(incomeable: event.incomeable),
    ));
  }

  void _onTransferFromAbleChanged(AccountFormTransferFromAbleChanged event, Emitter<AccountFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(transferFromAble: event.transferFromAble),
    ));
  }

  void _onTransferToAbleChanged(AccountFormTransferToAbleChanged event, Emitter<AccountFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(transferToAble: event.transferToAble),
    ));
  }

  void _onIncludeChanged(AccountFormIncludeChanged event, Emitter<AccountFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(include: event.include),
    ));
  }

  void _onNotesChanged(AccountFormNotesChanged event, Emitter<AccountFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(notes: event.notes),
    ));
  }

  void _onLimitChanged(AccountFormLimitChanged event, Emitter<AccountFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(limit: event.limit),
    ));
  }

  void _onBillDayChanged(AccountFormBillDayChanged event, Emitter<AccountFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(billDay: event.billDay),
    ));
  }

  void _onAprChanged(AccountFormAprChanged event, Emitter<AccountFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(apr: event.apr),
    ));
  }

  void _onDefaultLoaded(AccountFormDefaultLoaded event, Emitter<AccountFormState> emit) {
    emit(state.copyWith(
      status: FormzStatus.pure,
      request: state.request.copyWith(
        currencyCode: event.account?.currencyCode ?? authBloc.state.session!.defaultGroup.defaultCurrencyCode,
        name: event.account?.name ?? '',
        balance: event.account != null ? removeDecimalZero(event.account!.balance) : null,
        no: event.account?.no ?? '',
        expenseable: event.account?.expenseable ?? event.accountType == 1 || event.accountType == 2 ? true : false,
        incomeable: event.account?.incomeable ?? event.accountType == 1 ? true : false,
        transferFromAble: event.account?.transferFromAble ?? true,
        transferToAble: event.account?.transferToAble ?? event.accountType != 2 ? true : false,
        include: event.account?.include ?? true,
        notes: event.account?.notes ?? '',
        limit: event.account != null && event.account!.limit != null ? removeDecimalZero(event.account!.limit!) : null,
        billDay: event.account != null && event.account!.billDay != null  ? removeDecimalZero(event.account!.billDay!) : null,
        apr: event.account != null && event.account!.apr != null  ? removeDecimalZero(event.account!.apr!) : null,
      )
    ));
  }

  void _onSubmitted(AccountFormSubmitted event, Emitter<AccountFormState> emit) async {
    try {
      bool result = false;
      switch (event.type) {
        case 1:
          result = await accountRepository.add(event.accountType, state.request);
          break;
        case 2:
          result = await accountRepository.update(event.account!.id, state.request);
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
