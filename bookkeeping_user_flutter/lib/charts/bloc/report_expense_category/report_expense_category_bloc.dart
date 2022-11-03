import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '/commons/commons.dart';
import '/charts/charts.dart';

part 'report_expense_category_event.dart';
part 'report_expense_category_state.dart';

class ReportExpenseCategoryBloc extends Bloc<ReportExpenseCategoryEvent, ReportExpenseCategoryState> {

  final ReportRepository reportRepository;

  ReportExpenseCategoryBloc({
    required this.reportRepository
  }) : super(ReportExpenseCategoryState()) {
    on<ReportExpenseCategoryRefreshed>(_onRefreshed);
    on<ReportExpenseCategoryReset>(_onReset);
    on<ReportExpenseCategoryMinTimeChanged>(_onMinTimeChanged);
    on<ReportExpenseCategoryMaxTimeChanged>(_onMaxTimeChanged);
    on<ReportExpenseCategoryCategoryChanged>(_onCategoryChanged);
  }

  void _onRefreshed(_, Emitter<ReportExpenseCategoryState> emit) async {
    try {
      emit(state.copyWith(
        status: LoadDataStatus.progress,
        request: state.request.copyWith(
          minTime: state.request.minTime ?? DateTime.now().subtract(const Duration(days: 30)).millisecondsSinceEpoch,
          maxTime: state.request.maxTime ?? DateTime.now().millisecondsSinceEpoch,
        )
      ));
      final xys = await reportRepository.queryExpenseCategory(state.request);
      emit(state.copyWith(
        status: LoadDataStatus.success,
        xys: xys,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

  void _onMinTimeChanged(ReportExpenseCategoryMinTimeChanged event, Emitter<ReportExpenseCategoryState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(minTime: event.minTime),
    ));
  }

  void _onMaxTimeChanged(ReportExpenseCategoryMaxTimeChanged event, Emitter<ReportExpenseCategoryState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(maxTime: event.maxTime),
    ));
  }

  void _onCategoryChanged(ReportExpenseCategoryCategoryChanged event, Emitter<ReportExpenseCategoryState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(categoryId: event.categoryId),
    ));
  }

  void _onReset(_, Emitter<ReportExpenseCategoryState> emit) async {
    emit(state.copyWith(request: CategoryQueryRequest(
      minTime: DateTime.now().subtract(const Duration(days: 30)).millisecondsSinceEpoch,
      maxTime: DateTime.now().millisecondsSinceEpoch
    )));
    this.add(ReportExpenseCategoryRefreshed());
  }

}
