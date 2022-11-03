import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/charts/charts.dart';

part 'report_debt_state.dart';
part 'report_debt_event.dart';

class ReportDebtBloc extends Bloc<ReportDebtEvent, ReportDebtState> {

  final ReportRepository reportRepository;

  ReportDebtBloc({
    required this.reportRepository
  }) : super(ReportDebtStateLoadInProgress()) {
    on<ReportDebtLoaded>(_onReportDebtLoaded);
  }

  void _onReportDebtLoaded(_, Emitter<ReportDebtState> emit) async {
    try {
      emit(ReportDebtStateLoadInProgress());
      final xys = await reportRepository.getDebt();
      emit(ReportDebtStateLoadSuccess(xys));
    } catch (_) {
      emit(ReportDebtStateLoadFailure());
    }
  }

}