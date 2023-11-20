import 'package:app_ui/app_ui.dart';
import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:application_template/util/util.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  @override
  Future<void> close() {
    return super.close();
  }
}

abstract class FormController {
  void dispose();
}

class LoginFormController implements FormController {
  final AuthenticationHelperInterface _auth;
  late ValueNotifier<(FormSubmissionStateEnum, String?)> status;
  LoginFormController(this._auth) {
    status = ValueNotifier<(FormSubmissionStateEnum, String?)>(
        (FormSubmissionStateEnum.initial, null));
    formControl =
        FormControl.initiate<LoginFormField>(LoginFormField.values.length);
  }
  late FormControl<LoginFormField> formControl;
  void onEmailChanged(String email) {
    formControl.validate(
        isValid: email.isNotEmpty,
        content: email,
        errorMessage: 'Email not valid',
        currentFormFieldInUse: LoginFormField.emailOrUserName);
  }

  Future<void> submit() async {
    status.value = (FormSubmissionStateEnum.inProgress, null);
    final login = Login(
        email: formControl.getContent<String>(LoginFormField.emailOrUserName),
        password: formControl.getContent<String>(LoginFormField.password));

    final result = await _auth.signIn(login);
    if (result.isSuccessful) {
      status.value = (FormSubmissionStateEnum.successful, null);
      return;
    }
    status.value = (FormSubmissionStateEnum.serverFailure, result.errorMessage);
  }

  void onPasswordChanged(String password) {
    formControl.validate(
        isValid: password.isNotEmpty,
        content: password,
        errorMessage: 'Password not valid',
        currentFormFieldInUse: LoginFormField.password);
  }

  bool get isValid => formControl.formValidValueNotifier.value;
  @override
  void dispose() {
    formControl.dispose();
  }
}
