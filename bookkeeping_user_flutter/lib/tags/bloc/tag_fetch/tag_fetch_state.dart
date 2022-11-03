part of 'tag_fetch_bloc.dart';

@immutable
class TagFetchState extends Equatable {

  final LoadDataStatus status;
  final Tag? tag;

  const TagFetchState({
    this.status = LoadDataStatus.initial,
    this.tag,
  });

  TagFetchState copyWith({
    LoadDataStatus? status,
    Tag? tag,
  }) {
    return TagFetchState(
      status: status ?? this.status,
      tag: tag ?? this.tag,
    );
  }

  @override
  List<Object?> get props => [status, tag];

}
