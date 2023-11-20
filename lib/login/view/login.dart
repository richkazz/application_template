import 'package:app_ui/app_ui.dart';
import 'package:application_template/injection_container.dart';
import 'package:application_template/l10n/l10n.dart';
import 'package:application_template/login/controller/login_controller.dart';
import 'package:application_template/util/form_control.dart';
import 'package:application_template/util/util.dart';
import 'package:domain/src/emums/form_submission_tate_enum.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginView();
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
    loginStateFormControl.addListener(_onLoginStateFormControlStateChange);
    super.initState();
  }

  void _onLoginStateFormControlStateChange() {
    var state = loginStateFormControl.status;
    switch (state.$1) {
      case FormSubmissionStateEnum.initial:
      case FormSubmissionStateEnum.inProgress:
        AppNotify.showLoading();
      case FormSubmissionStateEnum.networkFailure:
        AppNotify.showError(
            errorMessage: 'NetWork error',
            voidCallback: () {
              AppNotify.dismissNotify();
            });
      case FormSubmissionStateEnum.serverFailure:
        AppNotify.showError(
            errorMessage: 'serverFailure error',
            voidCallback: () {
              AppNotify.dismissNotify();
            });
      case FormSubmissionStateEnum.successful:
        AppNotify.dismissNotify();
      case FormSubmissionStateEnum.error:
      // TODO: Handle this case.
      case FormSubmissionStateEnum.authenticationError:
      // TODO: Handle this case.
    }
  }

  @override
  void dispose() {
    loginStateFormControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SingleChildScrollView(
        child: FormControlFormInheritedWidget<LoginFormField>(
          formControl: loginStateFormControl.formControl,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text('Application login template',
                      style: Theme.of(context).textTheme.headlineMedium),
                ),
                const SizedBox(
                  height: AppSpacing.lg,
                ),
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
                    loginStateFormControl.onPasswordChanged(
                        password: value.$1,
                        errorMessage: l10n.passwordErrorText);
                  },
                ),
                const SizedBox(
                  height: AppSpacing.sm,
                ),
                AppButtonFormWrapper<LoginFormField>(
                  onPressed: loginStateFormControl.submit,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
