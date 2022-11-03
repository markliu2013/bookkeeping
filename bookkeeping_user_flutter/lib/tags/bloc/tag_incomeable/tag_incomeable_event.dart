part of 'tag_incomeable_bloc.dart';

abstract class TagIncomeableEvent extends Equatable {

  const TagIncomeableEvent();

  @override
  List<Object> get props => [];

}

class TagIncomeableLoaded extends TagIncomeableEvent { }