part of 'report_debt_bloc.dart';

abstract class ReportDebtEvent extends Equatable {
  const ReportDebtEvent();
  @override
  List<Object> get props => [];
}

class ReportDebtLoaded extends ReportDebtEvent { }