part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

/// AppStarted will be dispatched when the Flutter application first loads.
/// It will notify bloc that it needs to determine whether or not there is an existing user.
class AppStarted extends AuthEvent {
  @override
  String toString() => 'AppStarted';
}

/// LoggedIn will be dispatched on a successful login.
/// It will notify the bloc that the user has successfully logged in.
class LoggedIn extends AuthEvent {
  const LoggedIn(this.token);
  final String token;
  @override
  String toString() => 'LoggedIn { token: $token }';
}

/// LoggedOut will be dispatched on a successful logout.
/// It will notify the bloc that the user has successfully logged out.
class LoggedOut extends AuthEvent {
  @override
  String toString() => 'LoggedOut';
}

class DefaultBookChanged extends AuthEvent {
  final Book book;
  const DefaultBookChanged(this.book);
  @override
  List<Object> get props => [book];
}




