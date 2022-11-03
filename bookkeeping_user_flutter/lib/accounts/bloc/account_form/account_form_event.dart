part of 'account_form_bloc.dart';

@immutable
abstract class AccountFormEvent extends Equatable {
  const AccountFormEvent();
  @override
  List<Object?> get props => [];
}

class AccountFormCurrencyCodeChanged extends AccountFormEvent {
  const AccountFormCurrencyCodeChanged(this.currencyCode);
  final String currencyCode;
  @override
  List<Object> get props => [currencyCode];
}

class AccountFormNameChanged extends AccountFormEvent {
  const AccountFormNameChanged(this.name);
  final String name;
  @override
  List<Object> get props => [name];
}

class AccountFormBalanceChanged extends AccountFormEvent {
  const AccountFormBalanceChanged(this.balance);
  final String balance;
  @override
  List<Object> get props => [balance];
}

class AccountFormNoChanged extends AccountFormEvent {
  const AccountFormNoChanged(this.no);
  final String no;
  @override
  List<Object> get props => [no];
}

class AccountFormExpenseableChanged extends AccountFormEvent {
  const AccountFormExpenseableChanged(this.expenseable);
  final bool expenseable;
  @override
  List<Object> get props => [expenseable];
}

class AccountFormIncomeableChanged extends AccountFormEvent {
  const AccountFormIncomeableChanged(this.incomeable);
  final bool incomeable;
  @override
  List<Object> get props => [incomeable];
}

class AccountFormTransferFromAbleChanged extends AccountFormEvent {
  const AccountFormTransferFromAbleChanged(this.transferFromAble);
  final bool transferFromAble;
  @override
  List<Object> get props => [transferFromAble];
}

class AccountFormTransferToAbleChanged extends AccountFormEvent {
  const AccountFormTransferToAbleChanged(this.transferToAble);
  final bool transferToAble;
  @override
  List<Object> get props => [transferToAble];
}

class AccountFormIncludeChanged extends AccountFormEvent {
  const AccountFormIncludeChanged(this.include);
  final bool include;
  @override
  List<Object> get props => [include];
}

class AccountFormNotesChanged extends AccountFormEvent {
  const AccountFormNotesChanged(this.notes);
  final String notes;
  @override
  List<Object> get props => [notes];
}

class AccountFormLimitChanged extends AccountFormEvent {
  const AccountFormLimitChanged(this.limit);
  final String limit;
  @override
  List<Object> get props => [limit];
}

class AccountFormBillDayChanged extends AccountFormEvent {
  const AccountFormBillDayChanged(this.billDay);
  final String billDay;
  @override
  List<Object> get props => [billDay];
}

class AccountFormAprChanged extends AccountFormEvent {
  const AccountFormAprChanged(this.apr);
  final String apr;
  @override
  List<Object> get props => [apr];
}

class AccountFormDefaultLoaded extends AccountFormEvent {
  final int type;
  final int accountType;
  final Account? account;
  const AccountFormDefaultLoaded(this.type, this.accountType, this.account);
  @override
  List<Object?> get props => [type, accountType, account];
}

class AccountFormSubmitted extends AccountFormEvent {
  final int type;
  final int accountType;
  final Account? account;
  const AccountFormSubmitted(this.type, this.accountType, this.account);
  @override
  List<Object?> get props => [type, accountType, account];
}


