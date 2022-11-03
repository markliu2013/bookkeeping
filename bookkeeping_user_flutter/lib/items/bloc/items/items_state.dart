part of 'items_bloc.dart';

@immutable
class ItemsState extends Equatable {

  final LoadDataStatus status;
  final List<Item> items;
  final ItemQueryRequest request;
  final LoadDataStatus loadMoreStatus;
  final LoadDataStatus deleteStatus;

  const ItemsState({
    this.status = LoadDataStatus.initial,
    this.items = const <Item>[],
    this.request = const ItemQueryRequest(),
    this.loadMoreStatus = LoadDataStatus.initial,
    this.deleteStatus = LoadDataStatus.initial,
  });

  ItemsState copyWith({
    LoadDataStatus? status,
    List<Item>? items,
    ItemQueryRequest? request,
    LoadDataStatus? loadMoreStatus,
    LoadDataStatus? deleteStatus,
  }) {
    return ItemsState(
      status: status ?? this.status,
      items: items ?? this.items,
      request: request ?? this.request,
      loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }

  @override
  List<Object> get props => [status, request, loadMoreStatus, deleteStatus];

}
