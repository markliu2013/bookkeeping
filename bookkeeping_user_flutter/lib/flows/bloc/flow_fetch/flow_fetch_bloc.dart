import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '/commons/commons.dart';
import '/flows/flows.dart';

part 'flow_fetch_event.dart';
part 'flow_fetch_state.dart';

class FlowFetchBloc extends Bloc<FlowFetchEvent, FlowFetchState> {

  final FlowRepository flowRepository;

  FlowFetchBloc({
    required this.flowRepository,
  }) : super(FlowFetchState()) {
    on<FlowFetched>(_onFetched);
    on<FlowImagesFetched>(_onImagesFetched);
    on<FlowLoadDefault>(_onDefault);
    on<FlowImageDeleted>(_onImageDeleted);
    on<FlowImageUploaded>(_onImageUploaded);
  }

  void _onDefault(FlowLoadDefault event, Emitter<FlowFetchState> emit) {
    emit(state.copyWith(
      status: LoadDataStatus.success,
      flow: event.flow
    ));
  }

  void _onFetched(_, Emitter<FlowFetchState> emit) async {
    try {
      emit(state.copyWith(status: LoadDataStatus.progress));
      final flow = await flowRepository.get(state.flow!.id);
      emit(state.copyWith(
        status: LoadDataStatus.success,
        flow: flow,
      ));
    } catch (_) {
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

  void _onImagesFetched(_, Emitter<FlowFetchState> emit) async {
    try {
      final images = await flowRepository.getImages(state.flow!.id);
      emit(state.copyWith(
        images: images,
      ));
    } catch (_) {
      print(_);
    }
  }

  void _onImageDeleted(FlowImageDeleted event, Emitter<FlowFetchState> emit) async {
    try {
      emit(state.copyWith(deleteImageStatus: LoadDataStatus.progress));
      final result = await flowRepository.deleteImage(event.id);
      if (result) {
        emit(state.copyWith(deleteImageStatus: LoadDataStatus.success));
      } else {
        emit(state.copyWith(deleteImageStatus: LoadDataStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(deleteImageStatus: LoadDataStatus.failure));
    }
  }

  void _onImageUploaded(FlowImageUploaded event, Emitter<FlowFetchState> emit) async {
    try {
      emit(state.copyWith(uploadImageStatus: LoadDataStatus.progress));
      final result = await flowRepository.uploadImage(event.filePath, event.userId, event.flowId);
      if (result) {
        emit(state.copyWith(uploadImageStatus: LoadDataStatus.success));
      } else {
        emit(state.copyWith(uploadImageStatus: LoadDataStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(uploadImageStatus: LoadDataStatus.failure));
      print(_);
    }
  }

}
