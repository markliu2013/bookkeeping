import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/payees/payees.dart';

part 'payee_enable_event.dart';
part 'payee_enable_state.dart';

class PayeeEnableBloc extends Bloc<PayeeEnableEvent, PayeeEnableState> {

  final PayeeRepository payeeRepository;

  PayeeEnableBloc({
    required this.payeeRepository
  }) : super(PayeeEnableStateLoadInProgress()) {
    on<PayeeEnableLoaded>(_onPayeeEnableLoaded);
  }

  void _onPayeeEnableLoaded(_, Emitter<PayeeEnableState> emit) async {
    // 只加载一次数据
    // if (state is PayeeEnableStateLoadSuccess) return;
    try {
      emit(PayeeEnableStateLoadInProgress());
      final payees = await payeeRepository.getEnable();
      emit(PayeeEnableStateLoadSuccess(payees));
    } catch (_) {
      emit(PayeeEnableStateLoadFailure());
    }
  }

}