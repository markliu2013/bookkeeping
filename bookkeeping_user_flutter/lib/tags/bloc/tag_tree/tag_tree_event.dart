part of 'tag_tree_bloc.dart';

@immutable
abstract class TagTreeEvent extends Equatable {
  const TagTreeEvent();
  @override
  List<Object> get props => [];
}

class TagTreeRefreshed extends TagTreeEvent { }

class TagItemClicked extends TagTreeEvent {
  final TagTree tagTree;
  const TagItemClicked({
    required this.tagTree,
  });
}

class TagBackClicked extends TagTreeEvent { }

class TagDeleted extends TagTreeEvent {
  final String id;
  const TagDeleted(this.id);
  @override
  List<Object> get props => [id];
}

class TagToggled extends TagTreeEvent {
  final String id;
  const TagToggled(this.id);
  @override
  List<Object> get props => [id];
}