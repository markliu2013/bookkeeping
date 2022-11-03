part of 'flow_fetch_bloc.dart';

@immutable
class FlowFetchEvent extends Equatable {
  const FlowFetchEvent();
  @override
  List<Object> get props => [];
}

class FlowFetched extends FlowFetchEvent { }

class FlowImagesFetched extends FlowFetchEvent { }

class FlowLoadDefault extends FlowFetchEvent {
  final FlowModel flow;
  const FlowLoadDefault({
    required this.flow,
  });
  List<Object> get props => [flow];
}

class FlowImageDeleted extends FlowFetchEvent {
  final String id;
  const FlowImageDeleted(this.id);
  @override
  List<Object> get props => [id];
}

class FlowImageUploaded extends FlowFetchEvent {
  final String filePath;
  final String flowId;
  final String userId;
  const FlowImageUploaded(this.filePath, this.flowId, this.userId);
  @override
  List<Object> get props => [filePath, flowId, userId];
}
