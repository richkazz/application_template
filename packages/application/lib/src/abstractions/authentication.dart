import 'package:domain/domain.dart';

abstract class AuthenticationHelperInterface {
  bool get isUserSignedIn;
  String get userId;
  Stream<User> authStateChanges();

  Stream<User> get userStream;

  bool isEmailVerified();

  User? getUser();

  //SIGN UP METHOD
  ///Signup model and String displayName
  Future<User> signUp((SignUp signUp, String displayName) parm);

  Future<void> sendVerificationMail();

  Future<User> signIn(Login login);

  Future<User> verifySignInPassword(String password);

  //SIGN OUT METHOD
  Future<void> changePassword(String password);
  Future<void> forgetPassword(String email);
  Future<void> updateEmail(String email);

  Future<void> updateDisplayName(String displayName);

  Future<void> signOut();
}
