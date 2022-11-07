import 'package:bookkeeping_user_flutter/login/ui/widgets/api_url_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '/commons/commons.dart';
import '/login/login.dart';

class LoginForm extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          Message.success('登录成功');
        }
      },
      child: Column(
        children: [
          UsernameInput(),
          SizedBox(height: 10),
          PasswordInput(),
          SizedBox(height: 10),
          ApiUrlInput(),
          SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: SubmitBtn(),
          )
        ],
      )
    );
  }
}