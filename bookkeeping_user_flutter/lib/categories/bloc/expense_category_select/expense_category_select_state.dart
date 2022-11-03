part of 'expense_category_select_bloc.dart';


abstract class ExpenseCategorySelectState extends Equatable {

  const ExpenseCategorySelectState();

  @override
  List<Object> get props => [];

}

class ExpenseCategorySelectStateLoadInProgress extends ExpenseCategorySelectState { }

class ExpenseCategorySelectStateLoadSuccess extends ExpenseCategorySelectState {

  final List<Category> categories;

  const ExpenseCategorySelectStateLoadSuccess(this.categories);

  @override
  List<Object> get props => [categories];

}

class ExpenseCategorySelectStateLoadFailure extends ExpenseCategorySelectState { }