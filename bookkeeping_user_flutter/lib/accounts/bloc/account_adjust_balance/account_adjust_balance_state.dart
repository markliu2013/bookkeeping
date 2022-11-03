part of 'account_adjust_balance_bloc.dart';

@immutable
class AccountAdjustBalanceState extends Equatable {

  final FormzStatus status;
  final AdjustBalanceRequest request;

  const AccountAdjustBalanceState({
    this.status = FormzStatus.pure,
    this.request = const AdjustBalanceRequest(),
  });

  AccountAdjustBalanceState copyWith({
    FormzStatus? status,
    AdjustBalanceRequest? request,
  }) {
    return AccountAdjustBalanceState(
      status: status ?? this.status,
      request: request ?? this.request,
    );
  }

  @override
  List<Object?> get props => [status, request];

}
