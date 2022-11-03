part of 'item_form_bloc.dart';

class ItemFormState extends Equatable {

  final FormzStatus status;
  final Title title;
  final String? notes;
  final int? startDate;
  final int? endDate;
  final int? repeatType;
  final int? interval;

  const ItemFormState({
    this.status = FormzStatus.pure,
    this.title = const Title.pure(),
    this.notes,
    this.startDate = 1,
    this.endDate = 2,
    this.repeatType,
    this.interval
  });

  @override
  List<Object?> get props => [status, title, notes, startDate, endDate, repeatType, interval];

  ItemFormState copyWith({
    FormzStatus? status,
    Title? title,
    String? notes,
    int? startDate,
    int? endDate,
    int? repeatType,
    int? interval,
  }) {
    return ItemFormState(
      status: status ?? this.status,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      repeatType: repeatType ?? this.repeatType,
      interval: interval ?? this.interval,
    );
  }

}