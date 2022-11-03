part of 'payee_expenseable_bloc.dart';

abstract class PayeeExpenseableEvent extends Equatable {

  const PayeeExpenseableEvent();

  @override
  List<Object> get props => [];

}

class PayeeExpenseableLoaded extends PayeeExpenseableEvent { }