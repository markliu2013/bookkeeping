part of 'auth_bloc.dart';

enum AuthStatus { uninitialized, authenticated, unauthenticated, loading }

class AuthState extends Equatable {

  final AuthStatus status;
  final Session? session;

  const AuthState({
    this.status = AuthStatus.uninitialized,
    this.session
  });

  AuthState copyWith({
    AuthStatus? status,
    Session? session,
  }) {
    return AuthState(
      status: status ?? this.status,
      session: session ?? this.session,
    );
  }

  @override
  List<Object?> get props => [status, session];

}
