import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:data_access/data_access.dart';
import 'package:application/application.dart';

final applicationSl = GetIt.instance;

Future<void> applicationGetItInit({bool isTesting = false}) async {
  applicationSl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(applicationSl()));
  applicationSl.registerLazySingleton<HttpService>(() => DioHttpService(
        baseUrl: '',
        networkInfo: applicationSl(),
        headers: {},
      ));
  applicationSl.registerLazySingleton<ResultService>(() => ResultService());
  applicationSl.registerLazySingleton<AuthenticationHelperInterface>(
      () => AuthenticationHelperFirebaseService(applicationSl()));

  applicationSl.registerLazySingleton(() => DataConnectionChecker());
  // Register repositories
}
