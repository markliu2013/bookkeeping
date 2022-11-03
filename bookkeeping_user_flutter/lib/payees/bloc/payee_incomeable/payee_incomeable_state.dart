part of 'payee_incomeable_bloc.dart';

abstract class PayeeIncomeableState extends Equatable {

  const PayeeIncomeableState();

  @override
  List<Object> get props => [];

}

class PayeeIncomeableStateLoadInProgress extends PayeeIncomeableState { }

class PayeeIncomeableStateLoadSuccess extends PayeeIncomeableState {

  final List<Payee> payees;

  const PayeeIncomeableStateLoadSuccess(this.payees);

  @override
  List<Object> get props => [payees];

}

class PayeeIncomeableStateLoadFailure extends PayeeIncomeableState { }