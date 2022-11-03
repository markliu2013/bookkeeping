import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/tags/tags.dart';

part 'tag_enable_event.dart';
part 'tag_enable_state.dart';

class TagEnableBloc extends Bloc<TagEnableEvent, TagEnableState> {

  final TagRepository tagRepository;

  TagEnableBloc({
    required this.tagRepository
  }) : super(TagEnableStateLoadInProgress()) {
    on<TagEnableLoaded>(_onTagEnableLoaded);
  }

  void _onTagEnableLoaded(_, Emitter<TagEnableState> emit) async {
    // 只加载一次数据
    // if (state is TagEnableStateLoadSuccess) return;
    try {
      emit(TagEnableStateLoadInProgress());
      final tags = await tagRepository.getEnable();
      emit(TagEnableStateLoadSuccess(tags));
    } catch (_) {
      emit(TagEnableStateLoadFailure());
    }
  }

}