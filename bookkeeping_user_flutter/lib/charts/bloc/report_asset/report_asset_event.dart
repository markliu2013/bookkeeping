part of 'report_asset_bloc.dart';

abstract class ReportAssetEvent extends Equatable {
  const ReportAssetEvent();
  @override
  List<Object> get props => [];
}

class ReportAssetLoaded extends ReportAssetEvent { }