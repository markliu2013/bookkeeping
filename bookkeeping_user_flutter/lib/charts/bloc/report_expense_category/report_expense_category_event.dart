part of 'report_expense_category_bloc.dart';

@immutable
abstract class ReportExpenseCategoryEvent extends Equatable {
  const ReportExpenseCategoryEvent();
  @override
  List<Object> get props => [];
}

class ReportExpenseCategoryRefreshed extends ReportExpenseCategoryEvent { }

class ReportExpenseCategoryReset extends ReportExpenseCategoryEvent { }

class ReportExpenseCategoryMinTimeChanged extends ReportExpenseCategoryEvent {
  const ReportExpenseCategoryMinTimeChanged(this.minTime);
  final int minTime;
  @override
  List<Object> get props => [minTime];
}

class ReportExpenseCategoryMaxTimeChanged extends ReportExpenseCategoryEvent {
  const ReportExpenseCategoryMaxTimeChanged(this.maxTime);
  final int maxTime;
  @override
  List<Object> get props => [maxTime];
}

class ReportExpenseCategoryCategoryChanged extends ReportExpenseCategoryEvent {
  const ReportExpenseCategoryCategoryChanged(this.categoryId);
  final String categoryId;
  @override
  List<Object> get props => [categoryId];
}