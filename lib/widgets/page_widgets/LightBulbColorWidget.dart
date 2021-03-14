import 'package:flutter/material.dart';
import 'package:tasmota_control/models/LightBulb.dart';
import 'package:tasmota_control/services/DatabaseProvider.dart';
import 'package:tasmota_control/services/TasmotaProvider.dart';

class LightBulbColorWidget extends StatefulWidget {
  final LightBulb lightBulb;
  final Function notifyParent;
  LightBulbColorWidget({Key key, this.lightBulb, @required this.notifyParent})
      : super(key: key);
  @override
  _LightBulbColorState createState() => _LightBulbColorState();
}

class _LightBulbColorState extends State<LightBulbColorWidget> {
  DatabaseProvider dbProvider = DatabaseProvider();
  TasmotaProvider apiProvider = TasmotaProvider();

  @override
  Widget build(BuildContext context) {
    // Splits given HSB color and takes Hue value
    double _color = double.parse(widget.lightBulb.color.split(',')[0]);
    print(widget.lightBulb.color);

    return Visibility(
        visible: widget.lightBulb.power,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(children: <Widget>[
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text("Color", style: infoTextStyle))),
            Row(children: <Widget>[
              Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.palette, size: 30)),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: colorGradient,
                            stops: colorStops,
                          )),
                      child: Slider(
                        min: 0,
                        max: 359,
                        value: _color.toDouble(),
                        onChanged: (double newValue) {
                          setState(
                              () => widget.lightBulb.setHue(newValue.toInt()));
                        },
                        onChangeEnd: (double newValue) {
                          dbProvider.updateLB(widget.lightBulb);
                          apiProvider.setColor(widget.lightBulb);
                          widget.notifyParent();
                        },
                      )))
            ])
          ]),
        ));
  }
}

TextStyle infoTextStyle =
    TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white);

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
