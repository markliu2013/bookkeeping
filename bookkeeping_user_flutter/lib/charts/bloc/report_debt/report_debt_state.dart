part of 'report_debt_bloc.dart';

abstract class ReportDebtState extends Equatable {
  const ReportDebtState();
  @override
  List<Object> get props => [];
}

class ReportDebtStateLoadInProgress extends ReportDebtState { }

class ReportDebtStateLoadSuccess extends ReportDebtState {
  final List<XY> xys;
  const ReportDebtStateLoadSuccess(this.xys);
  @override
  List<Object> get props => [xys];
  num get total {
    num total = xys.fold(0, (previousValue, element) => previousValue + element.y*100);
    // 解决精度问题
    return total / 100;
  }
}

class ReportDebtStateLoadFailure extends ReportDebtState { }