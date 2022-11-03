import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/payees/payees.dart';

part 'payee_expenseable_event.dart';
part 'payee_expenseable_state.dart';

class PayeeExpenseableBloc extends Bloc<PayeeExpenseableEvent, PayeeExpenseableState> {

  final PayeeRepository payeeRepository;

  PayeeExpenseableBloc({
    required this.payeeRepository
  }) : super(PayeeExpenseableStateLoadInProgress()) {
    on<PayeeExpenseableLoaded>(_onPayeeExpenseableLoaded);
  }

  void _onPayeeExpenseableLoaded(_, Emitter<PayeeExpenseableState> emit) async {
    // 只加载一次数据
    // if (state is PayeeExpenseableStateLoadSuccess) return;
    try {
      emit(PayeeExpenseableStateLoadInProgress());
      final payees = await payeeRepository.getExpenseable();
      emit(PayeeExpenseableStateLoadSuccess(payees));
    } catch (_) {
      emit(PayeeExpenseableStateLoadFailure());
    }
  }

}