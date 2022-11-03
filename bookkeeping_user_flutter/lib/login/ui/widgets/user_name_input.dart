import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/login/login.dart';

class UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          onChanged: (username) => context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            hintText: '用户名',
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            errorText: state.username.invalid ? '请输入用户名' : null,
          ),
        );
      },
    );
  }
}