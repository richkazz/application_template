import 'package:application_template/app/app.dart';
import 'package:application_template/injection_container.dart';
import 'package:flutter/material.dart';

void main() async {
  await initiateGetIt();
  runApp(const App());
}
