part of 'payees_bloc.dart';

@immutable
abstract class PayeesEvent extends Equatable {
  const PayeesEvent();
  @override
  List<Object> get props => [];
}

class PayeesRefreshed extends PayeesEvent {}

class PayeesLoadMore extends PayeesEvent {}

class PayeeDeleted extends PayeesEvent {
  final String id;
  const PayeeDeleted(this.id);
  @override
  List<Object> get props => [id];
}

class PayeeToggled extends PayeesEvent {
  final String id;
  const PayeeToggled(this.id);
  @override
  List<Object> get props => [id];
}

class PayeesSortChanged extends PayeesEvent {
  const PayeesSortChanged(this.sort);
  final String sort;
  @override
  List<Object> get props => [sort];
}
