import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'models/models.dart';
import '/items/items.dart';

part 'item_form_event.dart';
part 'item_form_state.dart';

class ItemFormBloc extends Bloc<ItemFormEvent, ItemFormState> {

  final ItemRepository itemRepository;

  ItemFormBloc({
    required this.itemRepository
  }) : super(const ItemFormState()) {
    on<ItemFormTitleChanged>(_onTitleChanged);
    on<ItemFormNotesChanged>(_onNotesChanged);
    on<ItemFormDefaultLoaded>(_onDefaultLoaded);
    on<ItemFormAddSubmitted>(_onAddSubmitted);
  }

  void _onTitleChanged(ItemFormTitleChanged event, Emitter<ItemFormState> emit) {
    final title = Title.dirty(event.title);
    emit(state.copyWith(
      title: title,
      status: Formz.validate([title]),
    ));
  }

  void _onNotesChanged(ItemFormNotesChanged event, Emitter<ItemFormState> emit) {
    emit(state.copyWith(
      notes: event.notes,
    ));
  }

  void _onDefaultLoaded(ItemFormDefaultLoaded event, Emitter<ItemFormState> emit) {
    var now = DateTime.now();
    emit(state.copyWith(
      status: FormzStatus.pure,
      startDate: now.millisecondsSinceEpoch,
      endDate: DateTime(now.year+100, now.month, now.day).millisecondsSinceEpoch
    ));
  }

  void _onAddSubmitted(ItemFormAddSubmitted event, Emitter<ItemFormState> emit) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await itemRepository.save(
          ItemAddRequest(
            title: state.title.value,
            notes: state.notes,
            startDate: 1232,
            endDate: 124142,
            repeatType: 1,
            interval: 2
          )
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

}
