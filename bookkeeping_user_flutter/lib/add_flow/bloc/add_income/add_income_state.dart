part of 'add_income_bloc.dart';

class AddIncomeState extends Equatable {

  final FormzStatus status;
  final DealAddRequest request;
  final String? currencyCode;

  const AddIncomeState({
    this.status = FormzStatus.pure,
    this.request = const DealAddRequest(),
    this.currencyCode
  });

  AddIncomeState copyWith({
    FormzStatus? status,
    DealAddRequest? request,
    String? currencyCode,
  }) {
    return AddIncomeState(
      status: status ?? this.status,
      request: request ?? this.request,
      currencyCode: currencyCode ?? this.currencyCode
    );
  }

  @override
  List<Object?> get props => [status, request, currencyCode];

}