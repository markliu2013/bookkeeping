part of 'tag_tree_bloc.dart';

@immutable
class TagTreeState extends Equatable {

  final LoadDataStatus status;
  final List<TagTree> tags;
  final LoadDataStatus deleteStatus;
  final LoadDataStatus toggleStatus;
  final List<TagTree> currentTags;
  final int currentLevel;
  final List<List<TagTree>> history;

  @override
  List<Object?> get props => [status, tags, deleteStatus, toggleStatus, currentTags, currentLevel, history];

  const TagTreeState({
    this.status = LoadDataStatus.initial,
    this.tags = const [],
    this.deleteStatus = LoadDataStatus.initial,
    this.toggleStatus = LoadDataStatus.initial,
    this.currentTags = const [],
    this.currentLevel = 1,
    this.history = const [],
  });

  TagTreeState copyWith({
    LoadDataStatus? status,
    List<TagTree>? tags,
    LoadDataStatus? deleteStatus,
    LoadDataStatus? toggleStatus,
    List<TagTree>? currentTags,
    String? title,
    int? currentLevel,
    List<List<TagTree>>? history
  }) {
    return TagTreeState(
      status: status ?? this.status,
      tags: tags ?? this.tags,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      toggleStatus: toggleStatus ?? this.toggleStatus,
      currentTags: currentTags ?? this.currentTags,
      currentLevel: currentLevel ?? this.currentLevel,
      history: history ?? this.history
    );
  }

}
