
import 'dart:io';
Future<bool> CheckInternetConn() async {
  late bool activeInternetConn = false;
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      activeInternetConn = true;
    }
  } on SocketException catch (_) {
    activeInternetConn = false;
  }

  return activeInternetConn;
}