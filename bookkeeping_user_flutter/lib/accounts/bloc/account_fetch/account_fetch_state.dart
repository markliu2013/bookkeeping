part of 'account_fetch_bloc.dart';

@immutable
class AccountFetchState extends Equatable {

  final LoadDataStatus status;
  final Account? account;

  const AccountFetchState({
    this.status = LoadDataStatus.initial,
    this.account,
  });

  AccountFetchState copyWith({
    LoadDataStatus? status,
    Account? account,
  }) {
    return AccountFetchState(
      status: status ?? this.status,
      account: account ?? this.account,
    );
  }

  @override
  List<Object?> get props => [status, account];

}
