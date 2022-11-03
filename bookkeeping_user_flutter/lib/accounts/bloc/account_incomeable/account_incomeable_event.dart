part of 'account_incomeable_bloc.dart';

abstract class AccountIncomeableEvent extends Equatable {
  const AccountIncomeableEvent();
  @override
  List<Object> get props => [];
}

class AccountIncomeableLoaded extends AccountIncomeableEvent { }