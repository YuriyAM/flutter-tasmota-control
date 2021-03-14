import 'package:flutter/material.dart';
import 'package:tasmota_control/models/LightBulb.dart';
import 'package:tasmota_control/services/DatabaseProvider.dart';
import 'package:tasmota_control/services/TasmotaProvider.dart';

class LightBulbBrightnessWidget extends StatefulWidget {
  final LightBulb lightBulb;
  final Function notifyParent;
  LightBulbBrightnessWidget(
      {Key key, this.lightBulb, @required this.notifyParent})
      : super(key: key);
  @override
  _LightBulbBrightnessState createState() => _LightBulbBrightnessState();
}

class _LightBulbBrightnessState extends State<LightBulbBrightnessWidget> {
  DatabaseProvider dbProvider = DatabaseProvider();
  TasmotaProvider apiProvider = TasmotaProvider();

  @override
  Widget build(BuildContext context) {
    int _brightness = int.parse(widget.lightBulb.color.split(',')[2]);

    return Visibility(
        visible: widget.lightBulb.power,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(children: <Widget>[
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text("Color Brightness", style: infoTextStyle))),
            Row(children: <Widget>[
              Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.brightness_medium, size: 30)),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.white])),
                      child: Slider(
                        min: 0,
                        max: 100,
                        value: _brightness.toDouble(),
                        onChanged: (double newValue) {
                          setState(() =>
                              widget.lightBulb.setBrightness(newValue.toInt()));
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
