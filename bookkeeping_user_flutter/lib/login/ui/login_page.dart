import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/login/login.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                  width: 200,
                  padding: EdgeInsets.only(top: 50.0, bottom: 60.0),
                  child: Image.asset('assets/images/logo.png')
              ),
              BlocProvider(
                create: (_) => LoginBloc(
                    loginRepository: RepositoryProvider.of<LoginRepository>(context),
                    authBloc: BlocProvider.of<AuthBloc>(context)
                ),
                child: LoginForm(),
              ),
              SizedBox(height: 50),
            ],
          )
        ),
      )
    );
  }

}