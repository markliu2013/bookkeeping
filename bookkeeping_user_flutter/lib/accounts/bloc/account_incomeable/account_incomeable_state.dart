part of 'account_incomeable_bloc.dart';

abstract class AccountIncomeableState extends Equatable {
  const AccountIncomeableState();
  @override
  List<Object> get props => [];
}

class AccountIncomeableStateLoadInProgress extends AccountIncomeableState { }

class AccountIncomeableStateLoadSuccess extends AccountIncomeableState {
  final List<Account> accounts;
  const AccountIncomeableStateLoadSuccess(this.accounts);
  @override
  List<Object> get props => [accounts];
}

class AccountIncomeableStateLoadFailure extends AccountIncomeableState { }