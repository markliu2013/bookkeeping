part of 'currency_all_bloc.dart';

abstract class CurrencyAllState extends Equatable {
  const CurrencyAllState();
  @override
  List<Object> get props => [];
}

class CurrencyAllStateLoadInProgress extends CurrencyAllState { }

class CurrencyAllStateLoadSuccess extends CurrencyAllState {
  final List<Currency> currencies;
  const CurrencyAllStateLoadSuccess(this.currencies);
  @override
  List<Object> get props => [currencies];
}

class CurrencyAllStateLoadFailure extends CurrencyAllState { }