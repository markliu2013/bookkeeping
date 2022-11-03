part of 'add_expense_bloc.dart';

abstract class AddExpenseEvent extends Equatable {
  const AddExpenseEvent();
  @override
  List<Object?> get props => [];
}

class AddExpenseCreateTimeChanged extends AddExpenseEvent {
  const AddExpenseCreateTimeChanged(this.time);
  final TimeOfDay time;
  @override
  List<Object> get props => [time];
}

class AddExpenseCreateDateChanged extends AddExpenseEvent {
  const AddExpenseCreateDateChanged(this.dateTime);
  final DateTime dateTime;
  @override
  List<Object> get props => [dateTime];
}

class AddExpenseAccountChanged extends AddExpenseEvent {
  const AddExpenseAccountChanged(this.accountId);
  final String accountId;
  @override
  List<Object> get props => [accountId];
}

class AddExpensePayeeChanged extends AddExpenseEvent {
  const AddExpensePayeeChanged(this.payeeId);
  final String payeeId;
  @override
  List<Object> get props => [payeeId];
}

class AddExpenseCategoryChanged extends AddExpenseEvent {
  const AddExpenseCategoryChanged(this.categoryIds, this.categoryNames);
  final List<String> categoryIds;
  final List<String> categoryNames;
  @override
  List<Object> get props => [categoryIds, categoryNames];
}

class AddExpenseTagChanged extends AddExpenseEvent {
  const AddExpenseTagChanged(this.tags);
  final List<String> tags;
  @override
  List<Object> get props => [tags];
}

class AddExpenseAmountChanged extends AddExpenseEvent {
  const AddExpenseAmountChanged(this.categoryId, this.amount);
  final String categoryId;
  final String amount;
  @override
  List<Object> get props => [categoryId, amount];
}

class AddExpenseConvertedAmountChanged extends AddExpenseEvent {
  const AddExpenseConvertedAmountChanged(this.categoryId, this.convertedAmount);
  final String categoryId;
  final String convertedAmount;
  @override
  List<Object> get props => [categoryId, convertedAmount];
}

class AddExpenseDescriptionChanged extends AddExpenseEvent {
  const AddExpenseDescriptionChanged(this.description);
  final String description;
  @override
  List<Object> get props => [description];
}

class AddExpenseNotesChanged extends AddExpenseEvent {
  const AddExpenseNotesChanged(this.notes);
  final String notes;
  @override
  List<Object> get props => [notes];
}

class AddExpenseConfirmedChanged extends AddExpenseEvent {
  const AddExpenseConfirmedChanged(this.confirmed);
  final bool confirmed;
  @override
  List<Object> get props => [confirmed];
}

class AddExpenseDefaultLoaded extends AddExpenseEvent {
  final int type;
  final Deal? deal;
  const AddExpenseDefaultLoaded(this.type, this.deal);
  @override
  List<Object?> get props => [type, deal];
}

class AddExpenseSubmitted extends AddExpenseEvent {
  final int type;
  final Deal? deal;
  const AddExpenseSubmitted(this.type, this.deal);
  @override
  List<Object?> get props => [type, deal];
}