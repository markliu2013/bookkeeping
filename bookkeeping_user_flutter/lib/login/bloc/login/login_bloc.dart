import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '/login/login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc({
    required this.loginRepository,
    required this.authBloc
  }) : super(LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginApiUrlChanged>(_onApiUrlChanged);
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  final LoginRepository loginRepository;
  final AuthBloc authBloc;

  void _onUsernameChanged(LoginUsernameChanged event, Emitter<LoginState> emit) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([username, state.password, state.apiUrl]),
    ));
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username, state.apiUrl]),
    ));
  }

  void _onApiUrlChanged(LoginApiUrlChanged event, Emitter<LoginState> emit) {
    final url = ApiUrl.dirty(event.url);
    emit(state.copyWith(
      apiUrl: url,
      status: Formz.validate([url, state.username, state.password]),
    ));
  }

  void _onLoginButtonPressed(_, Emitter<LoginState> emit) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await loginRepository.saveApiUrl(state.apiUrl.value);
        String token = await loginRepository.logIn(username: state.username.value, password: state.password.value);
        authBloc.add(LoggedIn(token));
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

}