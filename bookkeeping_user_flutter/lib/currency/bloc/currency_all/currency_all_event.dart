part of 'currency_all_bloc.dart';

abstract class CurrencyAllEvent extends Equatable {
  const CurrencyAllEvent();
  @override
  List<Object> get props => [];
}

class CurrencyAllLoaded extends CurrencyAllEvent { }