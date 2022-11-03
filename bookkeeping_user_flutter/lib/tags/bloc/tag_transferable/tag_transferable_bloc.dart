import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/tags/tags.dart';

part 'tag_transferable_event.dart';
part 'tag_transferable_state.dart';

class TagTransferableBloc extends Bloc<TagTransferableEvent, TagTransferableState> {

  final TagRepository tagRepository;

  TagTransferableBloc({
    required this.tagRepository
  }) : super(TagTransferableStateLoadInProgress()) {
    on<TagTransferableLoaded>(_onTagTransferableLoaded);
  }

  void _onTagTransferableLoaded(_, Emitter<TagTransferableState> emit) async {
    // 只加载一次数据
    // if (state is TagTransferableStateLoadSuccess) return;
    try {
      emit(TagTransferableStateLoadInProgress());
      final tags = await tagRepository.getTransferable();
      emit(TagTransferableStateLoadSuccess(tags));
    } catch (_) {
      emit(TagTransferableStateLoadFailure());
    }
  }

}