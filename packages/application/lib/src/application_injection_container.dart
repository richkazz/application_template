import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:data_access/data_access.dart';
import 'package:application/application.dart';

final applicationSl = GetIt.instance;

Future<void> applicationGetItInit({bool isTesting = false}) async {
  applicationSl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(applicationSl()));

  applicationSl.registerLazySingleton<AuthenticationHelperInterface>(
      () => AuthenticationHelperFirebaseService());

  applicationSl.registerLazySingleton(() => DataConnectionChecker());
  // Register repositories
}
