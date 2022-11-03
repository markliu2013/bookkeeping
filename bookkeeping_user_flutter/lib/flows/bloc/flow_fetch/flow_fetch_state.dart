part of 'flow_fetch_bloc.dart';

@immutable
class FlowFetchState extends Equatable {

  final LoadDataStatus status;
  final FlowModel? flow;
  final List<FlowImage> images;
  final LoadDataStatus deleteImageStatus;
  final LoadDataStatus uploadImageStatus;

  const FlowFetchState({
    this.status = LoadDataStatus.initial,
    this.flow,
    this.images = const [],
    this.deleteImageStatus = LoadDataStatus.initial,
    this.uploadImageStatus = LoadDataStatus.initial,
  });

  FlowFetchState copyWith({
    LoadDataStatus? status,
    FlowModel? flow,
    List<FlowImage>? images,
    LoadDataStatus? deleteImageStatus,
    LoadDataStatus? uploadImageStatus,
  }) {
    return FlowFetchState(
      status: status ?? this.status,
      flow: flow ?? this.flow,
      images: images ?? this.images,
      deleteImageStatus: deleteImageStatus ?? this.deleteImageStatus,
      uploadImageStatus: uploadImageStatus ?? this.uploadImageStatus,
    );
  }

  @override
  List<Object?> get props => [status, flow, images, deleteImageStatus, uploadImageStatus];
}