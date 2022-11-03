import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '/login/login.dart';

class SubmitBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status.isValidated && !state.status.isSubmissionInProgress ?
              () {context.read<LoginBloc>().add(LoginButtonPressed());} : null,
          child: state.status.isSubmissionInProgress ?
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 1.5,
            ) : Text('登录')
        );
      },
    );
  }
}