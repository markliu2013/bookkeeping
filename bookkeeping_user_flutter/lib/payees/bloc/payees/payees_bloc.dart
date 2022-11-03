import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '/commons/commons.dart';
import '/payees/payees.dart';

part 'payees_event.dart';
part 'payees_state.dart';

class PayeesBloc extends Bloc<PayeesEvent, PayeesState> {

  final PayeeRepository payeeRepository;

  PayeesBloc({
    required this.payeeRepository,
  }) : super(PayeesState()) {
    on<PayeesRefreshed>(_onRefreshed);
    on<PayeesLoadMore>(_onLoadMore);
    on<PayeesSortChanged>(_onSortChanged);
    on<PayeeDeleted>(_onDeleted);
    on<PayeeToggled>(_onToggled);
  }

  void _onRefreshed(_, Emitter<PayeesState> emit) async {
    try {
      emit(state.copyWith(
        status: LoadDataStatus.progress,
        request: state.request.copyWith(page: 1),
      ));
      final payees = await payeeRepository.query(state.request);
      emit(state.copyWith(
        status: LoadDataStatus.success,
        payees: payees,
        request: state.request.copyWith(page: state.request.page + 1),
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

  void _onLoadMore(_, Emitter<PayeesState> emit) async {
    try {
      emit(state.copyWith(loadMoreStatus: LoadDataStatus.progress));
      final payees = await payeeRepository.query(state.request);
      if (payees.isNotEmpty) {
        emit(state.copyWith(
          request: state.request.copyWith(page: state.request.page + 1),
          payees: List.of(state.payees)..addAll(payees),
          loadMoreStatus: LoadDataStatus.success,
        ));
      } else {
        emit(state.copyWith(loadMoreStatus: LoadDataStatus.empty));
      }
    } catch (_) {
      emit(state.copyWith(loadMoreStatus: LoadDataStatus.failure));
    }
  }

  void _onSortChanged(PayeesSortChanged event, Emitter<PayeesState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(sort: event.sort),
    ));
  }

  void _onDeleted(PayeeDeleted event, Emitter<PayeesState> emit) async {
    try {
      emit(state.copyWith(deleteStatus: LoadDataStatus.progress));
      final result = await payeeRepository.delete(event.id);
      if (result) {
        emit(state.copyWith(deleteStatus: LoadDataStatus.success));
      } else {
        emit(state.copyWith(deleteStatus: LoadDataStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(deleteStatus: LoadDataStatus.failure));
    }
  }

  void _onToggled(PayeeToggled event, Emitter<PayeesState> emit) async {
    try {
      emit(state.copyWith(toggleStatus: LoadDataStatus.progress));
      final result = await payeeRepository.toggle(event.id);
      if (result) {
        emit(state.copyWith(toggleStatus: LoadDataStatus.success));
      } else {
        emit(state.copyWith(toggleStatus: LoadDataStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(toggleStatus: LoadDataStatus.failure));
    }
  }

}
