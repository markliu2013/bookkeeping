import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/login/login.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) => context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            hintText: '密码',
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            errorText: state.password.invalid ? '请输入密码' : null,
          ),
        );
      },
    );
  }
}