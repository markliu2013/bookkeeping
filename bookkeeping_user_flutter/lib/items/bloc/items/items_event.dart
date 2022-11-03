part of 'items_bloc.dart';

@immutable
abstract class ItemsEvent extends Equatable {
  const ItemsEvent();
  @override
  List<Object> get props => [];
}

class ItemsRefreshed extends ItemsEvent {}

class ItemsLoadMore extends ItemsEvent {}

class ItemDeleted extends ItemsEvent {
  final String id;
  const ItemDeleted(this.id);
  @override
  List<Object> get props => [id];
}

class ItemsSortChanged extends ItemsEvent {
  const ItemsSortChanged(this.sort);
  final String sort;
  @override
  List<Object> get props => [sort];
}