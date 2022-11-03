part of 'add_transfer_bloc.dart';

abstract class AddTransferEvent extends Equatable {
  const AddTransferEvent();
  @override
  List<Object?> get props => [];
}

class AddTransferCreateTimeChanged extends AddTransferEvent {
  const AddTransferCreateTimeChanged(this.time);
  final TimeOfDay time;
  @override
  List<Object> get props => [time];
}

class AddTransferCreateDateChanged extends AddTransferEvent {
  const AddTransferCreateDateChanged(this.dateTime);
  final DateTime dateTime;
  @override
  List<Object> get props => [dateTime];
}

class AddTransferFromChanged extends AddTransferEvent {
  const AddTransferFromChanged(this.fromId);
  final String fromId;
  @override
  List<Object> get props => [fromId];
}

class AddTransferToChanged extends AddTransferEvent {
  const AddTransferToChanged(this.toId);
  final String toId;
  @override
  List<Object> get props => [toId];
}

class AddTransferTagChanged extends AddTransferEvent {
  const AddTransferTagChanged(this.tags);
  final List<String> tags;
  @override
  List<Object> get props => [tags];
}

class AddTransferAmountChanged extends AddTransferEvent {
  const AddTransferAmountChanged(this.amount);
  final String amount;
  @override
  List<Object> get props => [amount];
}

class AddTransferConvertedAmountChanged extends AddTransferEvent {
  const AddTransferConvertedAmountChanged(this.convertedAmount);
  final String convertedAmount;
  @override
  List<Object> get props => [convertedAmount];
}

class AddTransferDescriptionChanged extends AddTransferEvent {
  const AddTransferDescriptionChanged(this.description);
  final String description;
  @override
  List<Object> get props => [description];
}

class AddTransferNotesChanged extends AddTransferEvent {
  const AddTransferNotesChanged(this.notes);
  final String notes;
  @override
  List<Object> get props => [notes];
}

class AddTransferConfirmedChanged extends AddTransferEvent {
  const AddTransferConfirmedChanged(this.confirmed);
  final bool confirmed;
  @override
  List<Object> get props => [confirmed];
}

class AddTransferDefaultLoaded extends AddTransferEvent {
  final int type;
  final Transfer? transfer;
  const AddTransferDefaultLoaded(this.type, this.transfer);
  @override
  List<Object?> get props => [type, transfer];
}

class AddTransferSubmitted extends AddTransferEvent {
  final int type;
  final Transfer? transfer;
  const AddTransferSubmitted(this.type, this.transfer);
  @override
  List<Object?> get props => [type, transfer];
}