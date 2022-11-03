import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/currency/currency.dart';

part 'currency_all_event.dart';
part 'currency_all_state.dart';

class CurrencyAllBloc extends Bloc<CurrencyAllEvent, CurrencyAllState> {

  final CurrencyRepository currencyRepository;

  CurrencyAllBloc({
    required this.currencyRepository
  }) : super(CurrencyAllStateLoadInProgress()) {
    on<CurrencyAllLoaded>(_onCurrencyAllLoaded);
  }

  void _onCurrencyAllLoaded(_, Emitter<CurrencyAllState> emit) async {
    // 只加载一次数据
    if (state is CurrencyAllStateLoadSuccess) return;
      emit(CurrencyAllStateLoadInProgress());
      final currencies = await currencyRepository.getAll();
      emit(CurrencyAllStateLoadSuccess(currencies));
  }

}