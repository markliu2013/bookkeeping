part of 'account_form_bloc.dart';

@immutable
class AccountFormState extends Equatable {

  final FormzStatus status;
  final AccountFormRequest request;

  const AccountFormState({
    this.status = FormzStatus.pure,
    this.request = const AccountFormRequest(),
  });

  AccountFormState copyWith({
    FormzStatus? status,
    AccountFormRequest? request,
  }) {
    return AccountFormState(
      status: status ?? this.status,
      request: request ?? this.request,
    );
  }

  @override
  List<Object> get props => [status, request];

}
