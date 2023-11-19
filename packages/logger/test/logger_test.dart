import 'package:flutter_test/flutter_test.dart';

import 'package:logger/logger.dart';

void main() {
  group('Logger', () {
    test('logInformation', () {
      final logger = Logger<String>();

      logger.logInformation('Test information message');
    });

    test('logError', () {
      final logger = Logger<String>();

      logger.logError('Test error message');
    });

    test('logError with error', () {
      final logger = Logger<String>();

      final error = Error();
      logger.logError('Test error message', error: error);
    });

    // Similar tests for logWarning, logDebug, and dispose.
  });
}
