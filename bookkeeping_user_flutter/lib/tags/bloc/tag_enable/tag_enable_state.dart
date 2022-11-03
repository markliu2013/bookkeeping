part of 'tag_enable_bloc.dart';

abstract class TagEnableState extends Equatable {

  const TagEnableState();

  @override
  List<Object> get props => [];

}

class TagEnableStateLoadInProgress extends TagEnableState { }

class TagEnableStateLoadSuccess extends TagEnableState {

  final List<Tag> tags;

  const TagEnableStateLoadSuccess(this.tags);

  @override
  List<Object> get props => [tags];

}

class TagEnableStateLoadFailure extends TagEnableState { }