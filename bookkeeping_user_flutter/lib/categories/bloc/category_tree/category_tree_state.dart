part of 'category_tree_bloc.dart';

@immutable
class CategoryTreeState extends Equatable {

  final LoadDataStatus status;
  final List<CategoryTree> categories;
  final LoadDataStatus deleteStatus;
  final LoadDataStatus toggleStatus;
  final List<CategoryTree> currentCategories;
  final int currentLevel;
  final List<List<CategoryTree>> history;

  @override
  List<Object?> get props => [status, categories, deleteStatus, toggleStatus, currentCategories, currentLevel, history];

  const CategoryTreeState({
    this.status = LoadDataStatus.initial,
    this.categories = const <CategoryTree>[],
    this.deleteStatus = LoadDataStatus.initial,
    this.toggleStatus = LoadDataStatus.initial,
    this.currentCategories = const <CategoryTree>[],
    this.currentLevel = 1,
    this.history = const <List<CategoryTree>>[],
  });

  CategoryTreeState copyWith({
    LoadDataStatus? status,
    List<CategoryTree>? categories,
    LoadDataStatus? deleteStatus,
    LoadDataStatus? toggleStatus,
    List<CategoryTree>? currentCategories,
    int? currentLevel,
    List<List<CategoryTree>>? history
  }) {
    return CategoryTreeState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      toggleStatus: toggleStatus ?? this.toggleStatus,
      currentCategories: currentCategories ?? this.currentCategories,
      currentLevel: currentLevel ?? this.currentLevel,
      history: history ?? this.history
    );
  }

}
