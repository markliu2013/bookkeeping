part of 'report_income_category_bloc.dart';

@immutable
abstract class ReportIncomeCategoryEvent extends Equatable {
  const ReportIncomeCategoryEvent();
  @override
  List<Object> get props => [];
}

class ReportIncomeCategoryRefreshed extends ReportIncomeCategoryEvent { }

class ReportIncomeCategoryReset extends ReportIncomeCategoryEvent { }

class ReportIncomeCategoryMinTimeChanged extends ReportIncomeCategoryEvent {
  const ReportIncomeCategoryMinTimeChanged(this.minTime);
  final int minTime;
  @override
  List<Object> get props => [minTime];
}

class ReportIncomeCategoryMaxTimeChanged extends ReportIncomeCategoryEvent {
  const ReportIncomeCategoryMaxTimeChanged(this.maxTime);
  final int maxTime;
  @override
  List<Object> get props => [maxTime];
}

class ReportIncomeCategoryCategoryChanged extends ReportIncomeCategoryEvent {
  const ReportIncomeCategoryCategoryChanged(this.categoryId);
  final String categoryId;
  @override
  List<Object> get props => [categoryId];
}