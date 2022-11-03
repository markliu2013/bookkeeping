part of 'payee_expenseable_bloc.dart';

abstract class PayeeExpenseableState extends Equatable {

  const PayeeExpenseableState();

  @override
  List<Object> get props => [];

}

class PayeeExpenseableStateLoadInProgress extends PayeeExpenseableState { }

class PayeeExpenseableStateLoadSuccess extends PayeeExpenseableState {

  final List<Payee> payees;

  const PayeeExpenseableStateLoadSuccess(this.payees);

  @override
  List<Object> get props => [payees];

}

class PayeeExpenseableStateLoadFailure extends PayeeExpenseableState { }