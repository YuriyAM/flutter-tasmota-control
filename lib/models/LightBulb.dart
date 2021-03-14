import 'package:flutter/material.dart';

class LightBulb {
  int id;
  String ip;
  String label;
  bool available;
  bool power;
  String color;

  LightBulb(
      {@required this.ip,
      this.label,
      this.available = false,
      this.power = false,
      this.color = '0,0,0'});

  // Convert a LightBulb object into a Map object
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ip': this.ip,
      'label': this.label,
      'available': this.available,
      'power': this.power,
      'color': this.color
    };
  }

  // Extract a LightBulb object from a Map object
  LightBulb.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.ip = map['ip'];
    this.label = map['label'];
    this.available = map['available'] == 0 ? false : true;
    this.power = map['power'] == 0 ? false : true;
    this.color = map['color'];
  }
//   Map<String, dynamic> toJson() {
//     return <String, dynamic>{
//       'ip': this.ip,
//       'label': this.label,
// //      'available': this.available,
//       'power': this.power,
//       'color': this.color
//     };
//   }

  LightBulb.fromJson(LightBulb lb, Map<String, dynamic> json) {
    this.ip = lb.ip;
    this.label = lb.label;
    this.available = lb.available;
    this.power = json['StatusSTS']["POWER"] == "OFF" ? false : true;
    this.color = json['StatusSTS']["HSBColor"];
  }

  setHue(int color) {
    List<String> hsb = this.color.split(',');
    hsb[0] = color.toString();
    this.color = hsb.join(',');
  }

  setSaturation(int saturation) {
    List<String> hsb = this.color.split(',');
    hsb[1] = saturation.toString();
    this.color = hsb.join(',');
  }

  setBrightness(int brightness) {
    List<String> hsb = this.color.split(',');
    hsb[2] = brightness.toString();
    this.color = hsb.join(',');
  }

  togglePower() => this.power == true ? this.power = false : this.power = true;

  setAvaialable(bool isAvailable) => this.available = isAvailable;
}
