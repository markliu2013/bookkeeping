import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/commons/commons.dart';
import '/flows/flows.dart';

part 'flows_event.dart';
part 'flows_state.dart';

class FlowsBloc extends Bloc<FlowsEvent, FlowsState> {

  final FlowRepository flowRepository;

  FlowsBloc({
    required this.flowRepository
  }) : super(FlowsState()) {
    on<FlowsLoadMore>(_onLoadMore);
    on<FlowsRefreshed>(_onRefreshed);
    on<FlowsReset>(_onReset);
    on<FlowsDeleted>(_onDeleted);
    on<FlowsConfirmed>(_onConfirmed);
    on<FlowsFilterPayeeChanged>(_onPayeeChanged);
    on<FlowsFilterCategoryChanged>(_onCategoryChanged);
    on<FlowsFilterTagChanged>(_onTagChanged);
    on<FlowsFilterTypeChanged>(_onTypeChanged);
    on<FlowsFilterStatusChanged>(_onStatusChanged);
    on<FlowsFilterAccountIdChanged>(_onAccountChanged);
    on<FlowsSortChanged>(_onSortChanged);
    on<FlowsFilterMinTimeChanged>(_onMinTimeChanged);
    on<FlowsFilterMaxTimeChanged>(_onMaxTimeChanged);
  }

  void _onRefreshed(_, Emitter<FlowsState> emit) async {
    try {
      var now = DateTime.now();
      emit(state.copyWith(
        status: LoadDataStatus.progress,
        request: state.request.copyWith(
          minTime: state.request.minTime ?? DateTime(now.year-1, now.month, now.day).millisecondsSinceEpoch,
          maxTime: state.request.maxTime ?? DateTime(now.year, now.month+1, now.day).millisecondsSinceEpoch,
          page: 1
        ),
      ));
      final flows = await flowRepository.query(state.request);
      emit(state.copyWith(
        status: LoadDataStatus.success,
        flows: flows,
        request: state.request.copyWith(page: state.request.page + 1),
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

  void _onReset(_, Emitter<FlowsState> emit) async {
    emit(state.copyWith(request: const FlowQueryRequest()));
    this.add(FlowsRefreshed());
  }

  void _onLoadMore(_, Emitter<FlowsState> emit) async {
    try {
      emit(state.copyWith(loadMoreStatus: LoadDataStatus.progress));
      final flows = await flowRepository.query(state.request);
      if (flows.isNotEmpty) {
        emit(state.copyWith(
          request: state.request.copyWith(page: state.request.page + 1),
          flows: List.of(state.flows)..addAll(flows),
          loadMoreStatus: LoadDataStatus.success,
        ));
      } else {
        emit(state.copyWith(loadMoreStatus: LoadDataStatus.empty));
      }
    } catch (_) {
      print(_);
      emit(state.copyWith(loadMoreStatus: LoadDataStatus.failure));
    }
  }

  void _onDeleted(FlowsDeleted event, Emitter<FlowsState> emit) async {
    try {
      emit(state.copyWith(deleteStatus: LoadDataStatus.progress));
      final result = await flowRepository.delete(event.id);
      if (result) {
        emit(state.copyWith(deleteStatus: LoadDataStatus.success));
      } else {
        emit(state.copyWith(deleteStatus: LoadDataStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(deleteStatus: LoadDataStatus.failure));
    }
  }

  void _onConfirmed(FlowsConfirmed event, Emitter<FlowsState> emit) async {
    try {
      emit(state.copyWith(confirmStatus: LoadDataStatus.progress));
      final result = await flowRepository.confirm(event.flow.id);
      if (result) {
        emit(state.copyWith(confirmStatus: LoadDataStatus.success));
      } else {
        emit(state.copyWith(confirmStatus: LoadDataStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(confirmStatus: LoadDataStatus.failure));
    }
  }

  void _onPayeeChanged(FlowsFilterPayeeChanged event, Emitter<FlowsState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(payees: [event.payeeId]),
    ));
  }

  void _onCategoryChanged(FlowsFilterCategoryChanged event, Emitter<FlowsState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(categories: [event.categoryId]),
    ));
  }

  void _onTagChanged(FlowsFilterTagChanged event, Emitter<FlowsState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(tags: [event.tagId]),
    ));
  }

  void _onTypeChanged(FlowsFilterTypeChanged event, Emitter<FlowsState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(type: event.type),
    ));
  }

  void _onStatusChanged(FlowsFilterStatusChanged event, Emitter<FlowsState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(status: event.status),
    ));
  }

  void _onAccountChanged(FlowsFilterAccountIdChanged event, Emitter<FlowsState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(accountId: event.accountId),
    ));
  }

  void _onSortChanged(FlowsSortChanged event, Emitter<FlowsState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(sort: event.sort),
    ));
  }

  void _onMinTimeChanged(FlowsFilterMinTimeChanged event, Emitter<FlowsState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(minTime: event.minTime),
    ));
  }

  void _onMaxTimeChanged(FlowsFilterMaxTimeChanged event, Emitter<FlowsState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(maxTime: event.maxTime),
    ));
  }

}
