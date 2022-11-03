import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/payees/payees.dart';

part 'payee_incomeable_event.dart';
part 'payee_incomeable_state.dart';

class PayeeIncomeableBloc extends Bloc<PayeeIncomeableEvent, PayeeIncomeableState> {

  final PayeeRepository payeeRepository;

  PayeeIncomeableBloc({
    required this.payeeRepository
  }) : super(PayeeIncomeableStateLoadInProgress()) {
    on<PayeeIncomeableLoaded>(_onPayeeIncomeableLoaded);
  }

  void _onPayeeIncomeableLoaded(_, Emitter<PayeeIncomeableState> emit) async {
    // 只加载一次数据
    // if (state is PayeeIncomeableStateLoadSuccess) return;
    try {
      emit(PayeeIncomeableStateLoadInProgress());
      final payees = await payeeRepository.getIncomeable();
      emit(PayeeIncomeableStateLoadSuccess(payees));
    } catch (_) {
      emit(PayeeIncomeableStateLoadFailure());
    }
  }

}