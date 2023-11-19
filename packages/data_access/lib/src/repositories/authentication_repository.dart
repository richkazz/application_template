import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:logger/logger.dart';

/// A service class responsible for handling authentication related tasks.
class AuthenticationHelperFirebaseService
    with LoggerMixin<AuthenticationHelperFirebaseService>
    implements AuthenticationHelperInterface {
  @override
  Stream<User> authStateChanges() {
    // TODO: implement authStateChanges
    throw UnimplementedError();
  }

  @override
  Future<void> changePassword(String password) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<void> forgetPassword(String email) {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  User? getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  bool isEmailVerified() {
    // TODO: implement isEmailVerified
    throw UnimplementedError();
  }

  @override
  // TODO: implement isUserSignedIn
  bool get isUserSignedIn => throw UnimplementedError();

  @override
  Future<void> sendVerificationMail() {
    // TODO: implement sendVerificationMail
    throw UnimplementedError();
  }

  @override
  Future<User> signIn(Login login) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<User> signUp((SignUp, String) parm) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<void> updateDisplayName(String displayName) {
    // TODO: implement updateDisplayName
    throw UnimplementedError();
  }

  @override
  Future<void> updateEmail(String email) {
    // TODO: implement updateEmail
    throw UnimplementedError();
  }

  @override
  // TODO: implement userId
  String get userId => throw UnimplementedError();

  @override
  // TODO: implement userStream
  Stream<User> get userStream => const Stream.empty();

  @override
  Future<User> verifySignInPassword(String password) {
    // TODO: implement verifySignInPassword
    throw UnimplementedError();
  }
}
