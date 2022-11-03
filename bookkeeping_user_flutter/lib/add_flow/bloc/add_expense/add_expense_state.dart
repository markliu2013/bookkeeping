part of 'add_expense_bloc.dart';

class AddExpenseState extends Equatable {

  final FormzStatus status;
  final DealAddRequest request;
  final String? currencyCode;

  const AddExpenseState({
    this.status = FormzStatus.pure,
    this.request = const DealAddRequest(),
    this.currencyCode
  });

  AddExpenseState copyWith({
    FormzStatus? status,
    DealAddRequest? request,
    String? currencyCode,
  }) {
    return AddExpenseState(
      status: status ?? this.status,
      request: request ?? this.request,
      currencyCode: currencyCode ?? this.currencyCode
    );
  }

  @override
  List<Object?> get props => [status, request, currencyCode];

}