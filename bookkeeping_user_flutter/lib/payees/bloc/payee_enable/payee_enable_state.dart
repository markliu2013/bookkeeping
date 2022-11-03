part of 'payee_enable_bloc.dart';

abstract class PayeeEnableState extends Equatable {

  const PayeeEnableState();

  @override
  List<Object> get props => [];

}

class PayeeEnableStateLoadInProgress extends PayeeEnableState { }

class PayeeEnableStateLoadSuccess extends PayeeEnableState {

  final List<Payee> payees;

  const PayeeEnableStateLoadSuccess(this.payees);

  @override
  List<Object> get props => [payees];

}

class PayeeEnableStateLoadFailure extends PayeeEnableState { }