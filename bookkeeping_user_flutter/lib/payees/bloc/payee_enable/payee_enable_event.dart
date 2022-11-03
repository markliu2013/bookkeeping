part of 'payee_enable_bloc.dart';

abstract class PayeeEnableEvent extends Equatable {

  const PayeeEnableEvent();

  @override
  List<Object> get props => [];

}

class PayeeEnableLoaded extends PayeeEnableEvent { }