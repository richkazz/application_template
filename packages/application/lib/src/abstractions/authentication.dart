import 'package:domain/domain.dart';

abstract class AuthenticationHelperInterface {
  bool get isUserSignedIn;
  String get userId;
  Stream<Result<User>> authStateChanges();

  Stream<User> get userStream;

  bool isEmailVerified();

  Result<User>? getUser();

  //SIGN UP METHOD
  ///Signup model and String displayName
  Future<Result<User>> signUp((SignUp signUp, String displayName) parm);

  Future<Result<User>> sendVerificationMail();

  Future<Result<User>> signIn(Login login);

  Future<Result<User>> verifySignInPassword(String password);

  //SIGN OUT METHOD
  Future<Result<User>> changePassword(String password);
  Future<Result<User>> forgetPassword(String email);
  Future<Result<User>> updateEmail(String email);

  Future<Result<User>> updateDisplayName(String displayName);

  Future<Result<User>> signOut();
}
