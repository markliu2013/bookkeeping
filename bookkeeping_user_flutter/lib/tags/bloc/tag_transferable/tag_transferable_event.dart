part of 'tag_transferable_bloc.dart';

abstract class TagTransferableEvent extends Equatable {

  const TagTransferableEvent();

  @override
  List<Object> get props => [];

}

class TagTransferableLoaded extends TagTransferableEvent { }