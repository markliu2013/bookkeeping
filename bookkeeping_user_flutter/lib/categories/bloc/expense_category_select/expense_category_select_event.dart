part of 'expense_category_select_bloc.dart';

abstract class ExpenseCategorySelectEvent extends Equatable {

  const ExpenseCategorySelectEvent();

  @override
  List<Object> get props => [];

}

class ExpenseCategorySelectLoaded extends ExpenseCategorySelectEvent { }