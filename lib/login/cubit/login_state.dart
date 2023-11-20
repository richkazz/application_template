part of 'login_cubit.dart';

enum LoginFormField {
  emailOrUserName,
  password;
}

class LoginState extends Equatable {
  const LoginState({
    this.isValid = false,
  });
  final bool isValid;
  @override
  List<Object> get props => [isValid];

  LoginState copyWith({
    bool? isValid,
  }) {
    return LoginState(
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  bool get stringify => true;
}
