part of 'account_expenseable_bloc.dart';

abstract class AccountExpenseableEvent extends Equatable {
  const AccountExpenseableEvent();
  @override
  List<Object> get props => [];
}

class AccountExpenseableLoaded extends AccountExpenseableEvent { }