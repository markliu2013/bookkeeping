import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '/tags/tags.dart';
import '/commons/commons.dart';

part 'tag_fetch_event.dart';
part 'tag_fetch_state.dart';

class TagFetchBloc extends Bloc<TagFetchEvent, TagFetchState> {

  final TagRepository tagRepository;

  TagFetchBloc({
    required this.tagRepository,
  }) : super(TagFetchState()) {
    on<TagFetched>(_onFetched);
    on<TagLoadDefault>(_onDefault);
  }

  void _onDefault(TagLoadDefault event, Emitter<TagFetchState> emit) {
    emit(state.copyWith(
      status: LoadDataStatus.success,
      tag: event.tag
    ));
  }

  void _onFetched(_, Emitter<TagFetchState> emit) async {
    try {
      emit(state.copyWith(status: LoadDataStatus.progress));
      final tag = await tagRepository.get(state.tag!.id);
      emit(state.copyWith(
        status: LoadDataStatus.success,
        tag: tag,
      ));
    } catch (_) {
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

}
