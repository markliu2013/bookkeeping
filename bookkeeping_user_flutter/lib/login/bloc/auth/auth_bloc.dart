import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/login/login.dart';
import '/books/books.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final LoginRepository loginRepository;

  AuthBloc({
    required this.loginRepository,
  }) : super(AuthState()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedOut>(_onLoggedOut);
    on<LoggedIn>(_onLoggedIn);
    on<DefaultBookChanged>(_onDefaultBookChanged);
  }

  void _onAppStarted(_, Emitter<AuthState> emit) async {
    final String token = await loginRepository.getToken();
    if (token.isNotEmpty) {
      try {
        Session sessionData = await loginRepository.getSession();
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          session: sessionData,
        ));
      } catch (_) {
        print(_);
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
        ));
      }
    } else {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
      ));
    }
  }

  void _onLoggedOut(_, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
    ));
    await loginRepository.deleteToken();
    emit(state.copyWith(
      status: AuthStatus.unauthenticated,
    ));
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
    ));
    await loginRepository.saveToken(event.token);
    emit(state.copyWith(
      status: AuthStatus.authenticated,
      session: await loginRepository.getSession(),
    ));
  }

  void _onDefaultBookChanged(DefaultBookChanged event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      session: state.session!.copyWith(defaultBook: event.book),
    ));
  }

}