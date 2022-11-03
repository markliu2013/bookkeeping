part of 'account_adjust_balance_bloc.dart';

@immutable
abstract class AccountAdjustBalanceEvent extends Equatable {
  const AccountAdjustBalanceEvent();
  @override
  List<Object?> get props => [];
}

class AccountAdjustBalanceCreateTimeChanged extends AccountAdjustBalanceEvent {
  const AccountAdjustBalanceCreateTimeChanged(this.time);
  final TimeOfDay time;
  @override
  List<Object> get props => [time];
}

class AccountAdjustBalanceCreateDateChanged extends AccountAdjustBalanceEvent {
  const AccountAdjustBalanceCreateDateChanged(this.dateTime);
  final DateTime dateTime;
  @override
  List<Object> get props => [dateTime];
}

class AccountAdjustBalanceBalanceChanged extends AccountAdjustBalanceEvent {
  const AccountAdjustBalanceBalanceChanged(this.balance);
  final String balance;
  @override
  List<Object> get props => [balance];
}


class AccountAdjustBalanceDescriptionChanged extends AccountAdjustBalanceEvent {
  const AccountAdjustBalanceDescriptionChanged(this.description);
  final String description;
  @override
  List<Object> get props => [description];
}

class AccountAdjustBalanceNotesChanged extends AccountAdjustBalanceEvent {
  const AccountAdjustBalanceNotesChanged(this.notes);
  final String notes;
  @override
  List<Object> get props => [notes];
}

class AccountAdjustBalanceDefaultLoaded extends AccountAdjustBalanceEvent {
  final int type;
  final AdjustBalance? adjustBalance;
  const AccountAdjustBalanceDefaultLoaded(this.type, this.adjustBalance);
  @override
  List<Object?> get props => [type, adjustBalance];
}

class AccountAdjustBalanceSubmitted extends AccountAdjustBalanceEvent {
  final int? accountId;
  final int type;
  final AdjustBalance? adjustBalance;
  const AccountAdjustBalanceSubmitted(this.type, this.accountId, this.adjustBalance);
  @override
  List<Object?> get props => [type, accountId, adjustBalance];
}