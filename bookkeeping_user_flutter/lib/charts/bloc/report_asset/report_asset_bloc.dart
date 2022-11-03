import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/charts/charts.dart';

part 'report_asset_state.dart';
part 'report_asset_event.dart';

class ReportAssetBloc extends Bloc<ReportAssetEvent, ReportAssetState> {

  final ReportRepository reportRepository;

  ReportAssetBloc({
    required this.reportRepository
  }) : super(ReportAssetStateLoadInProgress()) {
    on<ReportAssetLoaded>(_onReportAssetLoaded);
  }

  void _onReportAssetLoaded(_, Emitter<ReportAssetState> emit) async {
    try {
      emit(ReportAssetStateLoadInProgress());
      final xys = await reportRepository.getAsset();
      emit(ReportAssetStateLoadSuccess(xys));
    } catch (_) {
      emit(ReportAssetStateLoadFailure());
    }
  }

}