import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import '/categories/categories.dart';

part 'category_form_event.dart';
part 'category_form_state.dart';

class CategoryFormBloc extends Bloc<CategoryFormEvent, CategoryFormState> {

  final CategoryRepository categoryRepository;
  final ExpenseCategorySelectBloc expenseCategorySelectBloc;
  final IncomeCategorySelectBloc incomeCategorySelectBloc;

  CategoryFormBloc({
    required this.categoryRepository,
    required this.expenseCategorySelectBloc,
    required this.incomeCategorySelectBloc
  }) : super(const CategoryFormState()) {
    on<CategoryFormNameChanged>(_onNameChanged);
    on<CategoryFormNotesChanged>(_onNotesChanged);
    on<CategoryFormParentChanged>(_onParentChanged);
    on<CategoryFormDefaultLoaded>(_onDefaultLoaded);
    on<CategoryFormSubmitted>(_onSubmitted);
  }

  void _onNameChanged(CategoryFormNameChanged event, Emitter<CategoryFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(name: event.name),
    ));
  }

  void _onNotesChanged(CategoryFormNotesChanged event, Emitter<CategoryFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(notes: event.notes),
    ));
  }

  void _onParentChanged(CategoryFormParentChanged event, Emitter<CategoryFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(parentId: event.parentId),
    ));
  }

  void _onDefaultLoaded(CategoryFormDefaultLoaded event, Emitter<CategoryFormState> emit) {
    emit(state.copyWith(
      status: FormzStatus.pure,
      request: state.request.copyWith(
        name: event.type == 2 ? event.category?.name ?? '' : '',
        notes: event.type == 2 ? event.category?.notes ?? '' : '',
        parentId: event.type == 2 ? event.category?.parentId.toString() : event.category?.id.toString()
      )
    ));
  }

  void _onSubmitted(CategoryFormSubmitted event, Emitter<CategoryFormState> emit) async {
    try {
      bool result = false;
      switch (event.type) {
        case 1:
          result = await categoryRepository.add(event.categoryType, state.request);
          break;
        case 2:
          result = await categoryRepository.update(event.categoryType, event.category!.id, state.request);
          break;
        default:
          break;
      }
      if (result) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
        if (event.categoryType == 1) {
          expenseCategorySelectBloc.add(ExpenseCategorySelectLoaded());
        } else if (event.categoryType == 2) {
          incomeCategorySelectBloc.add(IncomeCategorySelectLoaded());
        }
      } else {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    } catch (_) {
      print(_);
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

}
