part of 'account_transfer_to_able_bloc.dart';

abstract class AccountTransferToAbleState extends Equatable {
  const AccountTransferToAbleState();
  @override
  List<Object> get props => [];
}

class AccountTransferToAbleStateLoadInProgress extends AccountTransferToAbleState { }

class AccountTransferToAbleStateLoadSuccess extends AccountTransferToAbleState {
  final List<Account> accounts;
  const AccountTransferToAbleStateLoadSuccess(this.accounts);
  @override
  List<Object> get props => [accounts];
}

class AccountTransferToAbleStateLoadFailure extends AccountTransferToAbleState { }