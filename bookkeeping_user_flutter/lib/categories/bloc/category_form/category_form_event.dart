part of 'category_form_bloc.dart';

@immutable
abstract class CategoryFormEvent extends Equatable {
  const CategoryFormEvent();
  @override
  List<Object?> get props => [];
}

class CategoryFormNameChanged extends CategoryFormEvent {
  const CategoryFormNameChanged(this.name);
  final String name;
  @override
  List<Object> get props => [name];
}

class CategoryFormNotesChanged extends CategoryFormEvent {
  const CategoryFormNotesChanged(this.notes);
  final String notes;
  @override
  List<Object> get props => [notes];
}

class CategoryFormParentChanged extends CategoryFormEvent {
  const CategoryFormParentChanged(this.parentId);
  final String parentId;
  @override
  List<Object> get props => [parentId];
}

class CategoryFormDefaultLoaded extends CategoryFormEvent {
  final int type;
  final int categoryType;
  final Category? category;
  const CategoryFormDefaultLoaded(this.type, this.categoryType, this.category);
  @override
  List<Object?> get props => [type, categoryType, category];
}

class CategoryFormSubmitted extends CategoryFormEvent {
  final int type;
  final int categoryType;
  final Category? category;
  const CategoryFormSubmitted(this.type, this.categoryType, this.category);
  @override
  List<Object?> get props => [type, categoryType, category];
}