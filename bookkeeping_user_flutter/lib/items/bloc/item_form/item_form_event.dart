part of 'item_form_bloc.dart';

abstract class ItemFormEvent extends Equatable {
  const ItemFormEvent();
  @override
  List<Object?> get props => [];
}

class ItemFormTitleChanged extends ItemFormEvent {
  const ItemFormTitleChanged(this.title);
  final String title;
  @override
  List<Object> get props => [title];
}

class ItemFormNotesChanged extends ItemFormEvent {
  const ItemFormNotesChanged(this.notes);
  final String notes;
  @override
  List<Object> get props => [notes];
}

class ItemFormStartDateChanged extends ItemFormEvent {
  const ItemFormStartDateChanged(this.startDate);
  final int startDate;
  @override
  List<Object> get props => [startDate];
}

class ItemFormEndDateChanged extends ItemFormEvent {
  const ItemFormEndDateChanged(this.endDate);
  final int endDate;
  @override
  List<Object> get props => [endDate];
}

class ItemFormRepeatTypeChanged extends ItemFormEvent {
  const ItemFormRepeatTypeChanged(this.repeatType);
  final int repeatType;
  @override
  List<Object> get props => [repeatType];
}

class ItemFormIntervalChanged extends ItemFormEvent {
  const ItemFormIntervalChanged(this.interval);
  final int interval;
  @override
  List<Object> get props => [interval];
}

class ItemFormDefaultLoaded extends ItemFormEvent {
  final int type;
  final Item? item;
  const ItemFormDefaultLoaded(this.type, this.item);
  @override
  List<Object?> get props => [type, item];
}

class ItemFormAddSubmitted extends ItemFormEvent {
  const ItemFormAddSubmitted();
}