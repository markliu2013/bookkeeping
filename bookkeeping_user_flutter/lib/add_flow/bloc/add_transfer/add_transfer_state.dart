part of 'add_transfer_bloc.dart';

class AddTransferState extends Equatable {

  final FormzStatus status;
  final TransferAddRequest request;
  final String? fromCurrencyCode;
  final String? toCurrencyCode;

  const AddTransferState({
    this.status = FormzStatus.pure,
    this.request = const TransferAddRequest(),
    this.fromCurrencyCode,
    this.toCurrencyCode
  });

  AddTransferState copyWith({
    FormzStatus? status,
    TransferAddRequest? request,
    String? fromCurrencyCode,
    String? toCurrencyCode
  }) {
    return AddTransferState(
      status: status ?? this.status,
      request: request ?? this.request,
      fromCurrencyCode: fromCurrencyCode ?? this.fromCurrencyCode,
      toCurrencyCode: toCurrencyCode ?? this.toCurrencyCode
    );
  }

  @override
  List<Object?> get props => [status, request, fromCurrencyCode, toCurrencyCode];

}