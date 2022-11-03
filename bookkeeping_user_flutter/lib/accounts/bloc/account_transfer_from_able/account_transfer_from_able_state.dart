part of 'account_transfer_from_able_bloc.dart';

abstract class AccountTransferFromAbleState extends Equatable {
  const AccountTransferFromAbleState();
  @override
  List<Object> get props => [];
}

class AccountTransferFromAbleStateLoadInProgress extends AccountTransferFromAbleState { }

class AccountTransferFromAbleStateLoadSuccess extends AccountTransferFromAbleState {
  final List<Account> accounts;
  const AccountTransferFromAbleStateLoadSuccess(this.accounts);
  @override
  List<Object> get props => [accounts];
}

class AccountTransferFromAbleStateLoadFailure extends AccountTransferFromAbleState { }