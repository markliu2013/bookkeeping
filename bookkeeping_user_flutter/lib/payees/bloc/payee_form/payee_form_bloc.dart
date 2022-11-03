import 'package:bloc/bloc.dart';
import 'package:bookkeeping_user_flutter/payees/payees.dart';
import 'package:bookkeeping_user_flutter/payees/data/models/payee_form_request.dart';
import 'package:bookkeeping_user_flutter/commons/commons.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'payee_form_event.dart';
part 'payee_form_state.dart';

class PayeeFormBloc extends Bloc<PayeeFormEvent, PayeeFormState> {

  final PayeeRepository payeeRepository;

  PayeeFormBloc({
    required this.payeeRepository,
  }) : super(const PayeeFormState()) {
    on<PayeeFormNameChanged>(_onNameChanged);
    on<PayeeFormExpenseableChanged>(_onExpenseableChanged);
    on<PayeeFormIncomeableChanged>(_onIncomeableChanged);
    on<PayeeFormNotesChanged>(_onNotesChanged);
    on<PayeeFormSubmitted>(_onSubmitted);
    on<PayeeFormDefaultLoaded>(_onDefaultLoaded);
  }

  void _onNameChanged(PayeeFormNameChanged event, Emitter<PayeeFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(name: event.name),
    ));
  }

  void _onExpenseableChanged(PayeeFormExpenseableChanged event, Emitter<PayeeFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(expenseable: event.expenseable),
    ));
  }

  void _onIncomeableChanged(PayeeFormIncomeableChanged event, Emitter<PayeeFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(incomeable: event.incomeable),
    ));
  }

  void _onNotesChanged(PayeeFormNotesChanged event, Emitter<PayeeFormState> emit) {
    emit(state.copyWith(
      request: state.request.copyWith(notes: event.notes),
    ));
  }

  void _onDefaultLoaded(PayeeFormDefaultLoaded event, Emitter<PayeeFormState> emit) {
    emit(state.copyWith(
      status: FormzStatus.pure,
      request: state.request.copyWith(
        name: event.payee?.name ?? '',
        expenseable: event.payee?.expenseable ?? true,
        incomeable: event.payee?.incomeable ?? false,
        notes: event.payee?.notes ?? '',
      )
    ));
  }

  void _onSubmitted(PayeeFormSubmitted event, Emitter<PayeeFormState> emit) async {
    try {
      bool result = false;
      switch (event.type) {
        case 1:
          result = await payeeRepository.add(state.request);
          break;
        case 2:
          result = await payeeRepository.update(event.payee!.id, state.request);
          break;
        default:
          break;
      }
      if (result) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

}
