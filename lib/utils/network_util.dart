import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtil {
  // Check network connectivity
  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult.isNotEmpty;
  }
}
