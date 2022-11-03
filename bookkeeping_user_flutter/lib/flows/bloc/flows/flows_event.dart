part of 'flows_bloc.dart';

abstract class FlowsEvent extends Equatable {
  const FlowsEvent();
  @override
  List<Object> get props => [];
}

class FlowsLoadMore extends FlowsEvent {}

class FlowsRefreshed extends FlowsEvent {}

class FlowsReset extends FlowsEvent {}

class FlowsDeleted extends FlowsEvent {
  final String id;
  const FlowsDeleted(this.id);
  @override
  List<Object> get props => [id];
}

class FlowsConfirmed extends FlowsEvent {
  final FlowModel flow;
  const FlowsConfirmed(this.flow);
  @override
  List<Object> get props => [flow];
}

class FlowsFilterPayeeChanged extends FlowsEvent {
  const FlowsFilterPayeeChanged(this.payeeId);
  final String payeeId;
  @override
  List<Object> get props => [payeeId];
}

class FlowsFilterCategoryChanged extends FlowsEvent {
  const FlowsFilterCategoryChanged(this.categoryId);
  final String categoryId;
  @override
  List<Object> get props => [categoryId];
}

class FlowsFilterTagChanged extends FlowsEvent {
  const FlowsFilterTagChanged(this.tagId);
  final String tagId;
  @override
  List<Object> get props => [tagId];
}

class FlowsFilterTypeChanged extends FlowsEvent {
  const FlowsFilterTypeChanged(this.type);
  final String type;
  @override
  List<Object> get props => [type];
}

class FlowsFilterStatusChanged extends FlowsEvent {
  const FlowsFilterStatusChanged(this.status);
  final String status;
  @override
  List<Object> get props => [status];
}

class FlowsFilterAccountIdChanged extends FlowsEvent {
  const FlowsFilterAccountIdChanged(this.accountId);
  final String accountId;
  @override
  List<Object> get props => [accountId];
}

class FlowsFilterMinTimeChanged extends FlowsEvent {
  const FlowsFilterMinTimeChanged(this.minTime);
  final int minTime;
  @override
  List<Object> get props => [minTime];
}

class FlowsFilterMaxTimeChanged extends FlowsEvent {
  const FlowsFilterMaxTimeChanged(this.maxTime);
  final int maxTime;
  @override
  List<Object> get props => [maxTime];
}

class FlowsSortChanged extends FlowsEvent {
  const FlowsSortChanged(this.sort);
  final String sort;
  @override
  List<Object> get props => [sort];
}