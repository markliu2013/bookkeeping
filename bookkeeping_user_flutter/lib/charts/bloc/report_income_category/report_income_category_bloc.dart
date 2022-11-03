import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '/commons/commons.dart';
import '/charts/charts.dart';

part 'report_income_category_event.dart';
part 'report_income_category_state.dart';

class ReportIncomeCategoryBloc extends Bloc<ReportIncomeCategoryEvent, ReportIncomeCategoryState> {

  final ReportRepository reportRepository;

  ReportIncomeCategoryBloc({
    required this.reportRepository
  }) : super(ReportIncomeCategoryState()) {
    on<ReportIncomeCategoryRefreshed>(_onRefreshed);
    on<ReportIncomeCategoryReset>(_onReset);
    on<ReportIncomeCategoryMinTimeChanged>(_onMinTimeChanged);
    on<ReportIncomeCategoryMaxTimeChanged>(_onMaxTimeChanged);
    on<ReportIncomeCategoryCategoryChanged>(_onCategoryChanged);
  }

  void _onRefreshed(_, Emitter<ReportIncomeCategoryState> emit) async {
    try {
      emit(state.copyWith(
          status: LoadDataStatus.progress,
          request: state.request.copyWith(
            minTime: state.request.minTime ?? DateTime.now().subtract(const Duration(days: 30)).millisecondsSinceEpoch,
            maxTime: state.request.maxTime ?? DateTime.now().millisecondsSinceEpoch,
          )
      ));
      final xys = await reportRepository.queryIncomeCategory(state.request);
      emit(state.copyWith(
        status: LoadDataStatus.success,
        xys: xys,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

  void _onMinTimeChanged(ReportIncomeCategoryMinTimeChanged event, Emitter<ReportIncomeCategoryState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(minTime: event.minTime),
    ));
  }

  void _onMaxTimeChanged(ReportIncomeCategoryMaxTimeChanged event, Emitter<ReportIncomeCategoryState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(maxTime: event.maxTime),
    ));
  }

  void _onCategoryChanged(ReportIncomeCategoryCategoryChanged event, Emitter<ReportIncomeCategoryState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(categoryId: event.categoryId),
    ));
  }

  void _onReset(_, Emitter<ReportIncomeCategoryState> emit) async {
    emit(state.copyWith(request: CategoryQueryRequest(
        minTime: DateTime.now().subtract(const Duration(days: 30)).millisecondsSinceEpoch,
        maxTime: DateTime.now().millisecondsSinceEpoch
    )));
    this.add(ReportIncomeCategoryRefreshed());
  }

}
