part of 'report_asset_bloc.dart';

abstract class ReportAssetState extends Equatable {
  const ReportAssetState();
  @override
  List<Object> get props => [];
}

class ReportAssetStateLoadInProgress extends ReportAssetState { }

class ReportAssetStateLoadSuccess extends ReportAssetState {
  final List<XY> xys;
  const ReportAssetStateLoadSuccess(this.xys);
  @override
  List<Object> get props => [xys];
  num get total {
    num total = xys.fold(0, (previousValue, element) => previousValue + element.y*100);
    return total / 100;
  }
}

class ReportAssetStateLoadFailure extends ReportAssetState { }