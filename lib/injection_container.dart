import 'dart:async';

import 'package:application_template/app/app.dart';
import 'package:application_template/login/cubit/login_cubit.dart';
import 'package:get_it/get_it.dart';

import 'package:domain/domain.dart';
import 'package:application/application.dart';

final mainSl = GetIt.instance;

Future initiateGetIt({bool isTesting = false}) async {
  User user = User.anonymous;

  mainSl.registerFactory(
    () => AppBloc(user: user, authenticationHelperInterface: mainSl()),
  );
  mainSl.registerFactory(
    () => LoginFormController(mainSl()),
  );

  await applicationGetItInit(isTesting: isTesting);
  //! Core
}
