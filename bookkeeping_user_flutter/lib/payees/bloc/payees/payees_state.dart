part of 'payees_bloc.dart';

@immutable
class PayeesState extends Equatable {

  final LoadDataStatus status;
  final List<Payee> payees;
  final PayeeQueryRequest request;
  final LoadDataStatus loadMoreStatus;
  final LoadDataStatus deleteStatus;
  final LoadDataStatus toggleStatus;

  const PayeesState({
    this.status = LoadDataStatus.initial,
    this.payees = const <Payee>[],
    this.request = const PayeeQueryRequest(),
    this.loadMoreStatus = LoadDataStatus.initial,
    this.deleteStatus = LoadDataStatus.initial,
    this.toggleStatus = LoadDataStatus.initial,
  });


  @override
  List<Object> get props => [status, payees, request, loadMoreStatus, deleteStatus, toggleStatus];

  PayeesState copyWith({
    LoadDataStatus? status,
    List<Payee>? payees,
    PayeeQueryRequest? request,
    LoadDataStatus? loadMoreStatus,
    LoadDataStatus? deleteStatus,
    LoadDataStatus? toggleStatus,
  }) {
    return PayeesState(
      status: status ?? this.status,
      payees: payees ?? this.payees,
      request: request ?? this.request,
      loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      toggleStatus: toggleStatus ?? this.toggleStatus,
    );
  }

}
