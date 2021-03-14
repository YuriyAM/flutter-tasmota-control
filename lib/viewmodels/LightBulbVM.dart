import 'package:tasmota_control/models/LightBulb.dart';

class LightBulbVM {
  final LightBulb lightBulb;

  LightBulbVM({this.lightBulb});

  // bool checkAvailable() {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       print('connected');
  //     }
  //   } on SocketException catch (_) {
  //     print('not connected');
  //   }
  // }
}
