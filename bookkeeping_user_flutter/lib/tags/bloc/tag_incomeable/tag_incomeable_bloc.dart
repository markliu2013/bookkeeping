import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/tags/tags.dart';

part 'tag_incomeable_event.dart';
part 'tag_incomeable_state.dart';

class TagIncomeableBloc extends Bloc<TagIncomeableEvent, TagIncomeableState> {

  final TagRepository tagRepository;

  TagIncomeableBloc({
    required this.tagRepository
  }) : super(TagIncomeableStateLoadInProgress()) {
    on<TagIncomeableLoaded>(_onTagIncomeableLoaded);
  }

  void _onTagIncomeableLoaded(_, Emitter<TagIncomeableState> emit) async {
    // 只加载一次数据
    // if (state is TagIncomeableStateLoadSuccess) return;
    try {
      emit(TagIncomeableStateLoadInProgress());
      final tags = await tagRepository.getIncomeable();
      emit(TagIncomeableStateLoadSuccess(tags));
    } catch (_) {
      emit(TagIncomeableStateLoadFailure());
    }
  }

}