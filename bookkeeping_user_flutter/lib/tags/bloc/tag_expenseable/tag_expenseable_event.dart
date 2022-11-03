part of 'tag_expenseable_bloc.dart';

abstract class TagExpenseableEvent extends Equatable {

  const TagExpenseableEvent();

  @override
  List<Object> get props => [];

}

class TagExpenseableLoaded extends TagExpenseableEvent { }