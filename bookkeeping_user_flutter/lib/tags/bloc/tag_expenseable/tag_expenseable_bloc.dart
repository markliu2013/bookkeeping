import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/tags/tags.dart';

part 'tag_expenseable_event.dart';
part 'tag_expenseable_state.dart';

class TagExpenseableBloc extends Bloc<TagExpenseableEvent, TagExpenseableState> {

  final TagRepository tagRepository;

  TagExpenseableBloc({
    required this.tagRepository
  }) : super(TagExpenseableStateLoadInProgress()) {
    on<TagExpenseableLoaded>(_onTagExpenseableLoaded);
  }

  void _onTagExpenseableLoaded(_, Emitter<TagExpenseableState> emit) async {
    // 只加载一次数据
    // if (state is TagExpenseableStateLoadSuccess) return;
    try {
      emit(TagExpenseableStateLoadInProgress());
      final tags = await tagRepository.getExpenseable();
      emit(TagExpenseableStateLoadSuccess(tags));
    } catch (_) {
      emit(TagExpenseableStateLoadFailure());
    }
  }

}