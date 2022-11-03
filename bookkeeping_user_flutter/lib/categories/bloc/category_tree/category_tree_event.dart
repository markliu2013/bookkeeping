part of 'category_tree_bloc.dart';

@immutable
abstract class CategoryTreeEvent extends Equatable {
  const CategoryTreeEvent();
  @override
  List<Object> get props => [];
}

class ExpenseCategoryTreeRefreshed extends CategoryTreeEvent { }

class IncomeCategoryTreeRefreshed extends CategoryTreeEvent { }

class CategoryItemClicked extends CategoryTreeEvent {
  final CategoryTree categoryTree;
  const CategoryItemClicked({
    required this.categoryTree,
  });
}

class CategoryBackClicked extends CategoryTreeEvent { }

class CategoryDeleted extends CategoryTreeEvent {
  final String id;
  const CategoryDeleted(this.id);
  @override
  List<Object> get props => [id];
}

class CategoryToggled extends CategoryTreeEvent {
  final String id;
  const CategoryToggled(this.id);
  @override
  List<Object> get props => [id];
}