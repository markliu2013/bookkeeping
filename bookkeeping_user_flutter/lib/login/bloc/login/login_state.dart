part of 'login_bloc.dart';

class LoginState extends Equatable {

  final FormzStatus status;
  final Username username;
  final Password password;
  ApiUrl apiUrl;

  LoginState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.apiUrl = const ApiUrl.dirty('http://testjz.jiukuaitech.com/api/v1/'),
  });

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    ApiUrl? apiUrl,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      apiUrl: apiUrl ?? this.apiUrl
    );
  }

  @override
  List<Object> get props => [status, username, password, apiUrl];
}
