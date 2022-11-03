part of 'account_transfer_from_able_bloc.dart';

abstract class AccountTransferFromAbleEvent extends Equatable {
  const AccountTransferFromAbleEvent();
  @override
  List<Object> get props => [];
}

class AccountTransferFromAbleLoaded extends AccountTransferFromAbleEvent { }