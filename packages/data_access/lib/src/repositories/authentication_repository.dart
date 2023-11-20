import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:logger/logger.dart';

/// A service class responsible for handling authentication related tasks.
class AuthenticationHelperFirebaseService
    with LoggerMixin<AuthenticationHelperFirebaseService>
    implements AuthenticationHelperInterface {
  AuthenticationHelperFirebaseService(this._resultService);
  final ResultService _resultService;

  @override
  // TODO: implement userId
  String get userId => throw UnimplementedError();

  @override
  // TODO: implement userStream
  Stream<User> get userStream => const Stream.empty();

  @override
  Stream<Result<User>> authStateChanges() {
    // TODO: implement authStateChanges
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> changePassword(String password) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> forgetPassword(String email) {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  Result<User>? getUser() {
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
  Future<Result<User>> sendVerificationMail() {
    // TODO: implement sendVerificationMail
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> signIn(Login login) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> signUp((SignUp, String) parm) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateDisplayName(String displayName) {
    // TODO: implement updateDisplayName
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateEmail(String email) {
    // TODO: implement updateEmail
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> verifySignInPassword(String password) {
    // TODO: implement verifySignInPassword
    throw UnimplementedError();
  }
}
