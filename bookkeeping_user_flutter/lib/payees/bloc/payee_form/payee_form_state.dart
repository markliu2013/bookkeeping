part of 'payee_form_bloc.dart';

@immutable
class PayeeFormState extends Equatable {

  final FormzStatus status;
  final PayeeFormRequest request;

  const PayeeFormState({
    this.status = FormzStatus.pure,
    this.request = const PayeeFormRequest(),
  });

  PayeeFormState copyWith({
    FormzStatus? status,
    PayeeFormRequest? request,
  }) {
    return PayeeFormState(
      status: status ?? this.status,
      request: request ?? this.request,
    );
  }

  @override
  List<Object> get props => [status, request];

}
