part of 'payee_fetch_bloc.dart';

@immutable
class PayeeFetchState extends Equatable {

  final LoadDataStatus status;
  final Payee? payee;

  const PayeeFetchState({
    this.status = LoadDataStatus.initial,
    this.payee,
  });

  PayeeFetchState copyWith({
    LoadDataStatus? status,
    Payee? payee,
  }) {
    return PayeeFetchState(
      status: status ?? this.status,
      payee: payee ?? this.payee,
    );
  }

  @override
  List<Object?> get props => [status, payee];

}
