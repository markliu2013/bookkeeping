import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '/commons/commons.dart';
import '/items/items.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {

  final ItemRepository itemRepository;

  ItemsBloc({
    required this.itemRepository,
  }) : super(ItemsState()) {
    on<ItemsRefreshed>(_onRefreshed);
    on<ItemsLoadMore>(_onLoadMore);
    on<ItemsSortChanged>(_onSortChanged);
    on<ItemDeleted>(_onDeleted);
  }

  void _onRefreshed(_, Emitter<ItemsState> emit) async {
    try {
      emit(state.copyWith(
        status: LoadDataStatus.progress,
        request: state.request.copyWith(page: 1),
      ));
      final items = await itemRepository.query(state.request);
      emit(state.copyWith(
        status: LoadDataStatus.success,
        items: items,
        request: state.request.copyWith(page: state.request.page + 1),
      ));
    } catch (_) {
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

  void _onLoadMore(_, Emitter<ItemsState> emit) async {
    try {
      emit(state.copyWith(loadMoreStatus: LoadDataStatus.progress));
      final items = await itemRepository.query(state.request);
      if (items.isNotEmpty) {
        emit(state.copyWith(
          request: state.request.copyWith(page: state.request.page + 1),
          items: List.of(state.items)..addAll(items),
          loadMoreStatus: LoadDataStatus.success,
        ));
      } else {
        emit(state.copyWith(loadMoreStatus: LoadDataStatus.empty));
      }
    } catch (_) {
      emit(state.copyWith(loadMoreStatus: LoadDataStatus.failure));
    }
  }

  void _onSortChanged(ItemsSortChanged event, Emitter<ItemsState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(sort: event.sort),
    ));
  }

  void _onDeleted(ItemDeleted event, Emitter<ItemsState> emit) async {
    try {
      emit(state.copyWith(deleteStatus: LoadDataStatus.progress));
      final result = await itemRepository.delete(event.id);
      if (result) {
        emit(state.copyWith(deleteStatus: LoadDataStatus.success));
      } else {
        emit(state.copyWith(deleteStatus: LoadDataStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(deleteStatus: LoadDataStatus.failure));
    }
  }

}
