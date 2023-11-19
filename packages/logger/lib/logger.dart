library logger;

import 'dart:developer' as dev;

import 'package:flutter/cupertino.dart';

enum LogType {
  debug,
  information,
  warning,
  error,
}

class Logger<T> {
  late String logClassName;

  Logger() {
    logClassName = T.toString();
  }

  @visibleForTesting
  void onNewLog(String message, LogType logType) {
    dev.log('-----------------------------------------');
    message
        .split('|||')
        .where((element) => element.isNotEmpty)
        .forEach((element) {
      dev.log(element);
    });
  }

  void logInformation(String message) {
    final formattedMessage = 'ClassName: $logClassName|||'
        'LogType: ${LogType.information}|||'
        'Message: $message';
    onNewLog(formattedMessage, LogType.information);
  }

  void logError(String message, {Object? error}) {
    var formattedMessage = 'ClassName: $logClassName|||'
        'LogType: ${LogType.error}|||'
        'Message: $message|||';
    if (error != null) {
      formattedMessage = '${formattedMessage}Error: ${error.toString()}';
    }

    onNewLog(formattedMessage, LogType.error);
  }

  void logWarning(String message) {
    final formattedMessage = 'ClassName: $logClassName|||'
        'LogType: ${LogType.warning}|||'
        'Message: $message';
    onNewLog(formattedMessage, LogType.warning);
  }

  void logDebug(String message) {
    final formattedMessage = 'ClassName: $logClassName|||'
        'LogType: ${LogType.debug}|||'
        'Message: $message';
    onNewLog(formattedMessage, LogType.debug);
  }

  void dispose() {
    logInformation('$logClassName disposed');
  }
}

mixin LoggerMixin<T> {
  final _logger = Logger<T>();
  void logDebug(String message) => _logger.logDebug(message);
  void logWarning(String message) => _logger.logWarning(message);
  void logInformation(String message) => _logger.logInformation(message);
  void logError(
    String message, {
    Object? error,
  }) =>
      _logger.logError(message, error: error);
  void logDispose() => _logger.dispose();
}
