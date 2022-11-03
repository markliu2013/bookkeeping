part of 'tag_transferable_bloc.dart';

abstract class TagTransferableState extends Equatable {

  const TagTransferableState();

  @override
  List<Object> get props => [];

}

class TagTransferableStateLoadInProgress extends TagTransferableState { }

class TagTransferableStateLoadSuccess extends TagTransferableState {

  final List<Tag> tags;

  const TagTransferableStateLoadSuccess(this.tags);

  @override
  List<Object> get props => [tags];

}

class TagTransferableStateLoadFailure extends TagTransferableState { }