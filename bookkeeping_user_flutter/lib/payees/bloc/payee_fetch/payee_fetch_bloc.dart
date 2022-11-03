import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '/payees/payees.dart';
import '/commons/commons.dart';

part 'payee_fetch_event.dart';
part 'payee_fetch_state.dart';

class PayeeFetchBloc extends Bloc<PayeeFetchEvent, PayeeFetchState> {

  final PayeeRepository payeeRepository;

  PayeeFetchBloc({
    required this.payeeRepository,
  }) : super(PayeeFetchState()) {
    on<PayeeFetched>(_onFetched);
    on<PayeeLoadDefault>(_onDefault);
  }

  void _onDefault(PayeeLoadDefault event, Emitter<PayeeFetchState> emit) {
    emit(state.copyWith(
      status: LoadDataStatus.success,
      payee: event.payee
    ));
  }

  void _onFetched(_, Emitter<PayeeFetchState> emit) async {
    try {
      emit(state.copyWith(status: LoadDataStatus.progress));
      final payee = await payeeRepository.get(state.payee!.id);
      emit(state.copyWith(
        status: LoadDataStatus.success,
        payee: payee,
      ));
    } catch (_) {
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

}
