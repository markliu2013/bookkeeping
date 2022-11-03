part of 'tag_expenseable_bloc.dart';

abstract class TagExpenseableState extends Equatable {

  const TagExpenseableState();

  @override
  List<Object> get props => [];

}

class TagExpenseableStateLoadInProgress extends TagExpenseableState { }

class TagExpenseableStateLoadSuccess extends TagExpenseableState {

  final List<Tag> tags;

  const TagExpenseableStateLoadSuccess(this.tags);

  @override
  List<Object> get props => [tags];

}

class TagExpenseableStateLoadFailure extends TagExpenseableState { }