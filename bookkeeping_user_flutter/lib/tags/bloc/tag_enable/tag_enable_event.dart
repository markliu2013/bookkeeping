part of 'tag_enable_bloc.dart';

abstract class TagEnableEvent extends Equatable {

  const TagEnableEvent();

  @override
  List<Object> get props => [];

}

class TagEnableLoaded extends TagEnableEvent { }