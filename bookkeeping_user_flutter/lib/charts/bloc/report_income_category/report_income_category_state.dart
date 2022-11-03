part of 'report_income_category_bloc.dart';

class ReportIncomeCategoryState extends Equatable {

  final LoadDataStatus status;
  final List<XY> xys;
  final CategoryQueryRequest request;

  const ReportIncomeCategoryState({
    this.status = LoadDataStatus.initial,
    this.xys = const <XY>[],
    this.request = const CategoryQueryRequest(),
  });

  ReportIncomeCategoryState copyWith({
    LoadDataStatus? status,
    List<XY>? xys,
    CategoryQueryRequest? request,
  }) {
    return ReportIncomeCategoryState(
      status: status ?? this.status,
      xys: xys ?? this.xys,
      request: request ?? this.request,
    );
  }

  num get total {
    if (status == LoadDataStatus.success) {
      num total = xys.fold(0, (previousValue, element) => previousValue + element.y);
      return num.parse(total.toStringAsFixed(2));
    } else {
      return 0;
    }
  }

  @override
  List<Object> get props => [status, xys, request];

}
