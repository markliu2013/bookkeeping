part of 'income_category_select_bloc.dart';


abstract class IncomeCategorySelectState extends Equatable {

  const IncomeCategorySelectState();

  @override
  List<Object> get props => [];

}

class IncomeCategorySelectStateLoadInProgress extends IncomeCategorySelectState { }

class IncomeCategorySelectStateLoadSuccess extends IncomeCategorySelectState {

  final List<Category> categories;

  const IncomeCategorySelectStateLoadSuccess(this.categories);

  @override
  List<Object> get props => [categories];

}

class IncomeCategorySelectStateLoadFailure extends IncomeCategorySelectState { }