import 'package:domain/domain.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<NetworkConnectionStatus> get onStatusChange;
}
