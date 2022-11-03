part of 'payee_fetch_bloc.dart';

@immutable
class PayeeFetchEvent extends Equatable {
  const PayeeFetchEvent();
  @override
  List<Object> get props => [];
}

class PayeeFetched extends PayeeFetchEvent {}

class PayeeLoadDefault extends PayeeFetchEvent {
  final Payee payee;
  const PayeeLoadDefault({
    required this.payee,
  });
  List<Object> get props => [payee];
}
