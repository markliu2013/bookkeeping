part of 'account_transfer_to_able_bloc.dart';

abstract class AccountTransferToAbleEvent extends Equatable {
  const AccountTransferToAbleEvent();
  @override
  List<Object> get props => [];
}

class AccountTransferToAbleLoaded extends AccountTransferToAbleEvent { }