import 'package:flutter/material.dart';
import 'package:tasmota_control/models/LightBulb.dart';
import 'package:tasmota_control/services/DatabaseProvider.dart';
import 'package:tasmota_control/services/TasmotaProvider.dart';

class LightBulbSaturationWidget extends StatefulWidget {
  final LightBulb lightBulb;
  LightBulbSaturationWidget({this.lightBulb});
  @override
  _LightBulbSaturationState createState() => _LightBulbSaturationState();
}

class _LightBulbSaturationState extends State<LightBulbSaturationWidget> {
  DatabaseProvider dbProvider = DatabaseProvider();
  TasmotaProvider apiProvider = TasmotaProvider();

  @override
  Widget build(BuildContext context) {
    // Splits given HSB color and takes Hue value
    double _color = double.parse(widget.lightBulb.color.split(',')[0]);
    double _saturation = double.parse(widget.lightBulb.color.split(',')[1]);
    double _brightness = double.parse(widget.lightBulb.color.split(',')[2]);

    return Visibility(
        visible: widget.lightBulb.power,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(children: <Widget>[
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text("Saturation", style: infoTextStyle))),
            Row(children: <Widget>[
              Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.format_color_fill, size: 30)),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            lerpGradient(brightnessGradient, brightnessStops,
                                _brightness / 100),
                            lerpGradient(
                                colorGradient, colorStops, _color / 359)
                          ])),
                      child: Slider(
                          min: 0,
                          max: 100,
                          value: _saturation,
                          onChanged: (value) {
                            setState(() =>
                                widget.lightBulb.setSaturation(value.toInt()));
                          },
                          onChangeEnd: (double newValue) {
                            dbProvider.updateLB(widget.lightBulb);
                            apiProvider.setColor(widget.lightBulb);
                          })))
            ])
          ]),
        ));
  }
}

TextStyle infoTextStyle =
    TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white);

Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s], rightStop = stops[s + 1];
    final leftColor = colors[s], rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT);
    }
  }
  return colors.last;
}

List<Color> colorGradient = [
  Color(0xFF800000),
  Color(0xFFF00000),
  Color(0xFFFFF000),
  Color(0xFF00F000),
  Color(0xFF00FFFF),
  Color(0xFF0000FF),
  Color(0xFFF00FFF),
  Color(0xFFF00000),
  Color(0xFF800000)
];
List<double> colorStops = [0, 0.05, 0.20, 0.35, 0.50, 0.65, 0.80, 0.95, 1];

List<Color> brightnessGradient = [Colors.black, Colors.white];
List<double> brightnessStops = [0, 1];
