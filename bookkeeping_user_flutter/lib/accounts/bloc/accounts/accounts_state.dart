part of 'accounts_bloc.dart';

@immutable
class AccountsState extends Equatable {

  final LoadDataStatus status;
  final List<Account> accounts;
  final AccountQueryRequest request;
  final LoadDataStatus loadMoreStatus;
  final LoadDataStatus deleteStatus;
  final LoadDataStatus toggleStatus;

  const AccountsState({
    this.status = LoadDataStatus.initial,
    this.accounts = const <Account>[],
    this.request = const AccountQueryRequest(),
    this.loadMoreStatus = LoadDataStatus.initial,
    this.deleteStatus = LoadDataStatus.initial,
    this.toggleStatus = LoadDataStatus.initial,
  });

  AccountsState copyWith({
    LoadDataStatus? status,
    List<Account>? accounts,
    AccountQueryRequest? request,
    LoadDataStatus? loadMoreStatus,
    LoadDataStatus? deleteStatus,
    LoadDataStatus? toggleStatus,
  }) {
    return AccountsState(
      status: status ?? this.status,
      accounts: accounts ?? this.accounts,
      request: request ?? this.request,
      loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      toggleStatus: toggleStatus ?? this.toggleStatus
    );
  }

  @override
  List<Object> get props => [status, request, loadMoreStatus, deleteStatus, toggleStatus];

}
