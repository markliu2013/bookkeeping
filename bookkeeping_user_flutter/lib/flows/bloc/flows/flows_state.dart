part of 'flows_bloc.dart';

class FlowsState extends Equatable {

  const FlowsState({
    this.status = LoadDataStatus.initial,
    this.flows = const <FlowModel>[],
    this.request = const FlowQueryRequest(),
    this.loadMoreStatus = LoadDataStatus.initial,
    this.deleteStatus = LoadDataStatus.initial,
    this.confirmStatus = LoadDataStatus.initial,
  });

  final LoadDataStatus status;
  final List<FlowModel> flows;
  final FlowQueryRequest request;
  final LoadDataStatus loadMoreStatus;
  final LoadDataStatus deleteStatus;
  final LoadDataStatus confirmStatus;

  FlowsState copyWith({
    LoadDataStatus? status,
    List<FlowModel>? flows,
    FlowQueryRequest? request,
    LoadDataStatus? loadMoreStatus,
    LoadDataStatus? deleteStatus,
    LoadDataStatus? confirmStatus
  }) {
    return FlowsState(
      status: status ?? this.status,
      flows: flows ?? this.flows,
      request: request ?? this.request,
      loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      confirmStatus: confirmStatus ?? this.confirmStatus
    );
  }

  @override
  List<Object> get props => [status, flows, request, loadMoreStatus, deleteStatus, confirmStatus];
}