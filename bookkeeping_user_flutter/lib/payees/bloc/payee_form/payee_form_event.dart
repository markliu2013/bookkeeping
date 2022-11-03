part of 'payee_form_bloc.dart';

@immutable
abstract class PayeeFormEvent extends Equatable {
  const PayeeFormEvent();
  @override
  List<Object?> get props => [];
}

class PayeeFormNameChanged extends PayeeFormEvent {
  const PayeeFormNameChanged(this.name);
  final String name;
  @override
  List<Object> get props => [name];
}

class PayeeFormExpenseableChanged extends PayeeFormEvent {
  const PayeeFormExpenseableChanged(this.expenseable);
  final bool expenseable;
  @override
  List<Object> get props => [expenseable];
}

class PayeeFormIncomeableChanged extends PayeeFormEvent {
  const PayeeFormIncomeableChanged(this.incomeable);
  final bool incomeable;
  @override
  List<Object> get props => [incomeable];
}

class PayeeFormNotesChanged extends PayeeFormEvent {
  const PayeeFormNotesChanged(this.notes);
  final String notes;
  @override
  List<Object> get props => [notes];
}

class PayeeFormDefaultLoaded extends PayeeFormEvent {
  final int type;
  final Payee? payee;
  const PayeeFormDefaultLoaded(this.type, this.payee);
  @override
  List<Object?> get props => [type, payee];
}

class PayeeFormSubmitted extends PayeeFormEvent {
  final int type;
  final Payee? payee;
  const PayeeFormSubmitted(this.type, this.payee);
  @override
  List<Object?> get props => [type, payee];
}