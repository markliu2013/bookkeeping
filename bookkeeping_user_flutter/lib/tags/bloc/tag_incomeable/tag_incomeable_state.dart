part of 'tag_incomeable_bloc.dart';

abstract class TagIncomeableState extends Equatable {

  const TagIncomeableState();

  @override
  List<Object> get props => [];

}

class TagIncomeableStateLoadInProgress extends TagIncomeableState { }

class TagIncomeableStateLoadSuccess extends TagIncomeableState {

  final List<Tag> tags;

  const TagIncomeableStateLoadSuccess(this.tags);

  @override
  List<Object> get props => [tags];

}

class TagIncomeableStateLoadFailure extends TagIncomeableState { }