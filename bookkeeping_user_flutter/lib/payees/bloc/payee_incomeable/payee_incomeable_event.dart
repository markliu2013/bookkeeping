part of 'payee_incomeable_bloc.dart';

abstract class PayeeIncomeableEvent extends Equatable {

  const PayeeIncomeableEvent();

  @override
  List<Object> get props => [];

}

class PayeeIncomeableLoaded extends PayeeIncomeableEvent { }