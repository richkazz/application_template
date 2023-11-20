import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:application_template/injection_container.dart';
import 'package:application_template/login/cubit/login_cubit.dart';
import 'package:application_template/util/form_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginFormController loginStateFormControl;
  @override
  void initState() {
    loginStateFormControl = mainSl<LoginFormController>();
    super.initState();
  }

  @override
  void dispose() {
    loginStateFormControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FormControlFormInheritedWidget<LoginFormField>(
          formControl: loginStateFormControl.formControl,
          child: Column(
            children: [
              Text('Application template',
                  style: Theme.of(context).textTheme.headlineMedium),
              const Text('Email/userName'),
              AppTextFormField<LoginFormField>(
                name: 'Email/userName',
                textFromFieldName: LoginFormField.emailOrUserName,
                onChanged: (value) {
                  loginStateFormControl.onEmailChanged(value.$1);
                },
              ),
              const Text('Password'),
              AppTextFormField<LoginFormField>(
                name: 'Password',
                textFromFieldName: LoginFormField.password,
                onChanged: (value) {
                  loginStateFormControl.onPasswordChanged(value.$1);
                },
              ),
              AppButtonFormWrapper<LoginFormField>(
                onPressed: () {},
                child: const Text('hi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
