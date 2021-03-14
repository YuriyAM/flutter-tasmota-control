import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:tasmota_control/models/LightBulb.dart';

class TasmotaProvider {
  static final TasmotaProvider tasmotaProvider = TasmotaProvider();

  // Future<LightBulb> syncightBulb(LightBulb lightBulb) {

  //   return

  // }
  Future<http.Response> togglePower(LightBulb lightBulb) async {
    if (lightBulb.power) {
      return await http.get("http://${lightBulb.ip}/cm?cmnd=Power%20ON");
    } else {
      return await http.get("http://${lightBulb.ip}/cm?cmnd=Power%20OFF");
    }
  }

  Future<http.Response> setColor(LightBulb lightBulb) async {
    return await http
        .get("http://${lightBulb.ip}/cm?cmnd=HSBColor%20${lightBulb.color}");
  }

  Future<http.Response> fetchSettings(LightBulb lightBulb) async {
    return await http.get("http://${lightBulb.ip}/cm?cmnd=Status%2011");
  }

  Future<bool> checkAvailable(String ip) async {
    try {
      await Socket.connect(ip, 80, timeout: Duration(seconds: 1));
      print("now");
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
