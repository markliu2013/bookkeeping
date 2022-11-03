part of 'tag_fetch_bloc.dart';

@immutable
class TagFetchEvent extends Equatable {
  const TagFetchEvent();
  @override
  List<Object> get props => [];
}

class TagFetched extends TagFetchEvent {}

class TagLoadDefault extends TagFetchEvent {
  final Tag tag;
  const TagLoadDefault({
    required this.tag,
  });
  List<Object> get props => [tag];
}
