part of 'accounts_bloc.dart';

@immutable
abstract class AccountsEvent extends Equatable {
  const AccountsEvent();
  @override
  List<Object> get props => [];
}

class AccountsRefreshed extends AccountsEvent {}

class AccountsLoadMore extends AccountsEvent {}

class AccountDeleted extends AccountsEvent {
  final String id;
  const AccountDeleted(this.id);
  @override
  List<Object> get props => [id];
}

class AccountToggled extends AccountsEvent {
  final String id;
  const AccountToggled(this.id);
  @override
  List<Object> get props => [id];
}

class AccountsTabChanged extends AccountsEvent {
  const AccountsTabChanged(this.tab);
  final int tab;
  @override
  List<Object> get props => [tab];
}

class AccountsSortChanged extends AccountsEvent {
  const AccountsSortChanged(this.sort);
  final String sort;
  @override
  List<Object> get props => [sort];
}