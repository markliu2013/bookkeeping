import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import '/tags/tags.dart';

part 'tag_form_event.dart';
part 'tag_form_state.dart';

class TagFormBloc extends Bloc<TagFormEvent, TagFormState> {

  final TagRepository tagRepository;
  final TagExpenseableBloc tagExpenseableBloc;
  final TagIncomeableBloc tagIncomeableBloc;
  final TagTransferableBloc tagTransferableBloc;
  final TagEnableBloc tagEnableBloc;

  TagFormBloc({
    required this.tagRepository,
    required this.tagExpenseableBloc,
    required this.tagIncomeableBloc,
    required this.tagTransferableBloc,
    required this.tagEnableBloc
  }) : super(const TagFormState()) {
    on<TagFormNameChanged>(_onNameChanged);
    on<TagFormNotesChanged>(_onNotesChanged);
    on<TagFormParentChanged>(_onParentChanged);
    on<TagFormExpenseableChanged>(_onExpenseableChanged);
    on<TagFormIncomeableChanged>(_onIncomeableChanged);
    on<TagFormTransferableChanged>(_onTransferableChanged);
    on<TagFormDefaultLoaded>(_onDefaultLoaded);
    on<TagFormSubmitted>(_onSubmitted);
  }

  void _onNameChanged(TagFormNameChanged event, Emitter<TagFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(name: event.name),
    ));
  }

  void _onNotesChanged(TagFormNotesChanged event, Emitter<TagFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(notes: event.notes),
    ));
  }

  void _onParentChanged(TagFormParentChanged event, Emitter<TagFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(parentId: event.parentId),
    ));
  }

  void _onExpenseableChanged(TagFormExpenseableChanged event, Emitter<TagFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(expenseable: event.expenseable),
    ));
  }

  void _onIncomeableChanged(TagFormIncomeableChanged event, Emitter<TagFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(incomeable: event.incomeable),
    ));
  }

  void _onTransferableChanged(TagFormTransferableChanged event, Emitter<TagFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(transferable: event.transferable),
    ));
  }

  void _onDefaultLoaded(TagFormDefaultLoaded event, Emitter<TagFormState> emit) {
    emit(state.copyWith(
      status: FormzStatus.pure,
      request: state.request.copyWith(
        name: event.type == 2 ? event.tag?.name ?? '' : '',
        notes: event.type == 2 ? event.tag?.notes ?? '' : '',
        parentId: event.type == 2 ? event.tag?.parentId.toString() : event.tag?.id.toString(),
        expenseable: event.tag?.expenseable ?? true,
        incomeable: event.tag?.incomeable ?? false,
        transferable: event.tag?.transferable ?? false
      )
    ));
  }

  void _onSubmitted(TagFormSubmitted event, Emitter<TagFormState> emit) async {
    try {
      bool result = false;
      switch (event.type) {
        case 1:
          result = await tagRepository.add(state.request);
          break;
        case 2:
          result = await tagRepository.update(event.tag!.id, state.request);
          break;
        default:
          break;
      }
      if (result) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
        tagExpenseableBloc.add(TagExpenseableLoaded());
        tagIncomeableBloc.add(TagIncomeableLoaded());
        tagTransferableBloc.add(TagTransferableLoaded());
        tagEnableBloc.add(TagEnableLoaded());
      } else {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    } catch (_) {
      print(_);
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

}
