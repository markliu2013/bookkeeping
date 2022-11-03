part of 'account_enable_bloc.dart';

abstract class AccountEnableEvent extends Equatable {
  const AccountEnableEvent();
  @override
  List<Object> get props => [];
}

class AccountEnableLoaded extends AccountEnableEvent { }