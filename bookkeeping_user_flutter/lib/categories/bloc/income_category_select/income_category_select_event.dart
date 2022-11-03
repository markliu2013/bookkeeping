part of 'income_category_select_bloc.dart';

abstract class IncomeCategorySelectEvent extends Equatable {

  const IncomeCategorySelectEvent();

  @override
  List<Object> get props => [];

}

class IncomeCategorySelectLoaded extends IncomeCategorySelectEvent { }