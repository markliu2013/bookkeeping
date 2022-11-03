import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '/tags/tags.dart';
import '/commons/commons.dart';

part 'tag_tree_event.dart';
part 'tag_tree_state.dart';

class TagTreeBloc extends Bloc<TagTreeEvent, TagTreeState> {

  final TagRepository tagRepository;
  final TagExpenseableBloc tagExpenseableBloc;
  final TagIncomeableBloc tagIncomeableBloc;
  final TagTransferableBloc tagTransferableBloc;
  final TagEnableBloc tagEnableBloc;

  TagTreeBloc({
    required this.tagRepository,
    required this.tagExpenseableBloc,
    required this.tagIncomeableBloc,
    required this.tagTransferableBloc,
    required this.tagEnableBloc,
  }) : super(TagTreeState()) {
    on<TagTreeRefreshed>(_onRefreshed);
    on<TagItemClicked>(_onItemClicked);
    on<TagBackClicked>(_onBackClicked);
    on<TagToggled>(_onToggled);
    on<TagDeleted>(_onDeleted);
  }

  void _onRefreshed(_, Emitter<TagTreeState> emit) async {
    try {
      emit(state.copyWith(
        status: LoadDataStatus.progress,
      ));
      final tags = await tagRepository.query();
      emit(state.copyWith(
        status: LoadDataStatus.success,
        tags: tags,
        currentTags: tags
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(status: LoadDataStatus.failure));
    }
  }

  void _onItemClicked(TagItemClicked event, Emitter<TagTreeState> emit) async {
    List<List<TagTree>> newHistory = List.from(state.history);
    newHistory.add(state.currentTags);
    emit(state.copyWith(
      currentLevel: state.currentLevel + 1,
      currentTags: event.tagTree.children,
      history: newHistory,
    ));
  }

  void _onBackClicked(TagBackClicked event, Emitter<TagTreeState> emit) async {
    emit(state.copyWith(
      currentLevel: state.currentLevel - 1,
      currentTags: state.history.last
    ));
  }

  void _onToggled(TagToggled event, Emitter<TagTreeState> emit) async {
    try {
      emit(state.copyWith(toggleStatus: LoadDataStatus.progress));
      final result = await tagRepository.toggle(event.id);
      if (result) {
        emit(state.copyWith(toggleStatus: LoadDataStatus.success));
        tagExpenseableBloc.add(TagExpenseableLoaded());
        tagIncomeableBloc.add(TagIncomeableLoaded());
        tagTransferableBloc.add(TagTransferableLoaded());
        tagEnableBloc.add(TagEnableLoaded());
      } else {
        emit(state.copyWith(toggleStatus: LoadDataStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(toggleStatus: LoadDataStatus.failure));
    }
  }

  void _onDeleted(TagDeleted event, Emitter<TagTreeState> emit) async {
    try {
      emit(state.copyWith(deleteStatus: LoadDataStatus.progress));
      final result = await tagRepository.delete(event.id);
      if (result) {
        emit(state.copyWith(deleteStatus: LoadDataStatus.success));
        tagExpenseableBloc.add(TagExpenseableLoaded());
        tagIncomeableBloc.add(TagIncomeableLoaded());
        tagTransferableBloc.add(TagTransferableLoaded());
        tagEnableBloc.add(TagEnableLoaded());
      } else {
        emit(state.copyWith(deleteStatus: LoadDataStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(deleteStatus: LoadDataStatus.failure));
    }
  }

}
