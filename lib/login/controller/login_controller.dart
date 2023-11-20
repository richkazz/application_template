import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:application_template/util/util.dart';
import 'package:flutter/widgets.dart';
import 'package:form_inputs/form_inputs.dart';

enum LoginFormField {
  emailOrUserName,
  password;
}

class LoginFormController with ChangeNotifier implements FormController {
  final AuthenticationHelperInterface _auth;
  late (FormSubmissionStateEnum, String?) _status;
  (FormSubmissionStateEnum, String?) get status => _status;

  LoginFormController(this._auth) {
    _status = (FormSubmissionStateEnum.initial, null);
    formControl =
        FormControl.initiate<LoginFormField>(LoginFormField.values.length);
  }
  late FormControl<LoginFormField> formControl;
  void onEmailChanged(String email) {
    formControl.validate(
        isValid: InputValidator.email(email),
        content: email,
        errorMessage: 'Email not valid',
        currentFormFieldInUse: LoginFormField.emailOrUserName);
  }

  Future<void> submit() async {
    _status = (FormSubmissionStateEnum.inProgress, null);
    notifyListeners();
    final login = Login(
        email: formControl.getContent<String>(LoginFormField.emailOrUserName),
        password: formControl.getContent<String>(LoginFormField.password));
    Future.delayed(Duration(seconds: 3));
    final result = Result(isSuccessful: true, errorMessage: null);
    //final result = await _auth.signIn(login);
    if (result.isSuccessful) {
      _status = (FormSubmissionStateEnum.successful, null);
      notifyListeners();
      return;
    }
    notifyListeners();
    _status = (FormSubmissionStateEnum.serverFailure, result.errorMessage);
  }

  void onPasswordChanged(
      {required String password, required String errorMessage}) {
    formControl.validate(
        isValid: InputValidator.password(password),
        content: password,
        errorMessage: errorMessage,
        currentFormFieldInUse: LoginFormField.password);
  }

  bool get isValid => formControl.formValidValueNotifier.value;
  @override
  void dispose() {
    formControl.dispose();
  }
}
