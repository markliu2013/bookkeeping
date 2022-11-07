import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/login/login.dart';

class ApiUrlInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.apiUrl != current.apiUrl,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.apiUrl.value,
          onChanged: (url) => context.read<LoginBloc>().add(LoginApiUrlChanged(url)),
          decoration: InputDecoration(
            hintText: 'API地址',
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            errorText: state.apiUrl.invalid ? '请输入API地址' : null,
          ),
        );
      },
    );
  }
}