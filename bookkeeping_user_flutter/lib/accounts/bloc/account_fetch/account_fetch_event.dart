part of 'account_fetch_bloc.dart';

@immutable
class AccountFetchEvent extends Equatable {
  const AccountFetchEvent();
  @override
  List<Object> get props => [];
}

class AccountFetched extends AccountFetchEvent {}

class AccountLoadDefault extends AccountFetchEvent {
  final Account account;
  const AccountLoadDefault({
    required this.account,
  });
  List<Object> get props => [account];
}
