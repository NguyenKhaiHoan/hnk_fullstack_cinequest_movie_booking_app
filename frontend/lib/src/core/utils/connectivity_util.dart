import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/external/services/connectivity/connectivity_service.dart';

class ConnectivityUtil {
  ConnectivityUtil._();

  static Future<bool> checkConnectivity() async {
    final connectivityService = sl<ConnectivityService>();
    return connectivityService.isConnected();
  }
}
