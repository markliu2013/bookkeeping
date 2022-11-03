part of 'add_income_bloc.dart';

abstract class AddIncomeEvent extends Equatable {
  const AddIncomeEvent();
  @override
  List<Object?> get props => [];
}

class AddIncomeCreateTimeChanged extends AddIncomeEvent {
  const AddIncomeCreateTimeChanged(this.time);
  final TimeOfDay time;
  @override
  List<Object> get props => [time];
}

class AddIncomeCreateDateChanged extends AddIncomeEvent {
  const AddIncomeCreateDateChanged(this.dateTime);
  final DateTime dateTime;
  @override
  List<Object> get props => [dateTime];
}

class AddIncomeAccountChanged extends AddIncomeEvent {
  const AddIncomeAccountChanged(this.accountId);
  final String accountId;
  @override
  List<Object> get props => [accountId];
}

class AddIncomePayeeChanged extends AddIncomeEvent {
  const AddIncomePayeeChanged(this.payeeId);
  final String payeeId;
  @override
  List<Object> get props => [payeeId];
}

class AddIncomeCategoryChanged extends AddIncomeEvent {
  const AddIncomeCategoryChanged(this.categoryIds, this.categoryNames);
  final List<String> categoryIds;
  final List<String> categoryNames;
  @override
  List<Object> get props => [categoryIds, categoryNames];
}

class AddIncomeTagChanged extends AddIncomeEvent {
  const AddIncomeTagChanged(this.tags);
  final List<String> tags;
  @override
  List<Object> get props => [tags];
}

class AddIncomeAmountChanged extends AddIncomeEvent {
  const AddIncomeAmountChanged(this.categoryId, this.amount);
  final String categoryId;
  final String amount;
  @override
  List<Object> get props => [categoryId, amount];
}

class AddIncomeConvertedAmountChanged extends AddIncomeEvent {
  const AddIncomeConvertedAmountChanged(this.categoryId, this.convertedAmount);
  final String categoryId;
  final String convertedAmount;
  @override
  List<Object> get props => [categoryId, convertedAmount];
}

class AddIncomeDescriptionChanged extends AddIncomeEvent {
  const AddIncomeDescriptionChanged(this.description);
  final String description;
  @override
  List<Object> get props => [description];
}

class AddIncomeNotesChanged extends AddIncomeEvent {
  const AddIncomeNotesChanged(this.notes);
  final String notes;
  @override
  List<Object> get props => [notes];
}

class AddIncomeConfirmedChanged extends AddIncomeEvent {
  const AddIncomeConfirmedChanged(this.confirmed);
  final bool confirmed;
  @override
  List<Object> get props => [confirmed];
}

class AddIncomeDefaultLoaded extends AddIncomeEvent {
  final int type;
  final Deal? deal;
  const AddIncomeDefaultLoaded(this.type, this.deal);
  @override
  List<Object?> get props => [type, deal];
}

class AddIncomeSubmitted extends AddIncomeEvent {
  final int type;
  final Deal? deal;
  const AddIncomeSubmitted(this.type, this.deal);
  @override
  List<Object?> get props => [type, deal];
}