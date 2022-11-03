part of 'account_enable_bloc.dart';

abstract class AccountEnableState extends Equatable {
  const AccountEnableState();
  @override
  List<Object> get props => [];
}

class AccountEnableStateLoadInProgress extends AccountEnableState { }

class AccountEnableStateLoadSuccess extends AccountEnableState {
  final List<Account> accounts;
  const AccountEnableStateLoadSuccess(this.accounts);
  @override
  List<Object> get props => [accounts];
}

class AccountEnableStateLoadFailure extends AccountEnableState { }