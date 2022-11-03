part of 'account_expenseable_bloc.dart';

abstract class AccountExpenseableState extends Equatable {
  const AccountExpenseableState();
  @override
  List<Object> get props => [];
}

class AccountExpenseableStateLoadInProgress extends AccountExpenseableState { }

class AccountExpenseableStateLoadSuccess extends AccountExpenseableState {
  final List<Account> accounts;
  const AccountExpenseableStateLoadSuccess(this.accounts);
  @override
  List<Object> get props => [accounts];
}

class AccountExpenseableStateLoadFailure extends AccountExpenseableState { }