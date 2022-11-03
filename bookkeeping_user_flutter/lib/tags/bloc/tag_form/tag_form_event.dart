part of 'tag_form_bloc.dart';

@immutable
abstract class TagFormEvent extends Equatable {
  const TagFormEvent();
  @override
  List<Object?> get props => [];
}

class TagFormNameChanged extends TagFormEvent {
  const TagFormNameChanged(this.name);
  final String name;
  @override
  List<Object> get props => [name];
}

class TagFormNotesChanged extends TagFormEvent {
  const TagFormNotesChanged(this.notes);
  final String notes;
  @override
  List<Object> get props => [notes];
}

class TagFormParentChanged extends TagFormEvent {
  const TagFormParentChanged(this.parentId);
  final String parentId;
  @override
  List<Object> get props => [parentId];
}

class TagFormExpenseableChanged extends TagFormEvent {
  const TagFormExpenseableChanged(this.expenseable);
  final bool expenseable;
  @override
  List<Object> get props => [expenseable];
}

class TagFormIncomeableChanged extends TagFormEvent {
  const TagFormIncomeableChanged(this.incomeable);
  final bool incomeable;
  @override
  List<Object> get props => [incomeable];
}

class TagFormTransferableChanged extends TagFormEvent {
  const TagFormTransferableChanged(this.transferable);
  final bool transferable;
  @override
  List<Object> get props => [transferable];
}

class TagFormDefaultLoaded extends TagFormEvent {
  final int type;
  final Tag? tag;
  const TagFormDefaultLoaded(this.type, this.tag);
  @override
  List<Object?> get props => [type, tag];
}

class TagFormSubmitted extends TagFormEvent {
  final int type;
  final Tag? tag;
  const TagFormSubmitted(this.type, this.tag);
  @override
  List<Object?> get props => [type, tag];
}