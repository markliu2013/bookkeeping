import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/components.dart';
import '/login/login.dart';
import 'index.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        if (state.status == AuthStatus.uninitialized) {
          return PageLoading();
        }
        if (state.status == AuthStatus.authenticated) {
          return IndexPage();
        }
        if (state.status == AuthStatus.unauthenticated) {
          return LoginPage();
        }
        if (state.status == AuthStatus.loading) {
          return PageLoading();
        }
        return Text('error');
      }
    );
  }
}
