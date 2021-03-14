import 'package:flutter/material.dart';
import 'package:tasmota_control/models/LightBulb.dart';
import 'package:tasmota_control/services/DatabaseProvider.dart';
import 'package:tasmota_control/services/TasmotaProvider.dart';

class LightBulbInfoWidget extends StatefulWidget {
  final LightBulb lightBulb;
  final Function notifyParent;
  LightBulbInfoWidget({Key key, this.lightBulb, @required this.notifyParent})
      : super(key: key);
  @override
  _LightBulbInfoState createState() => _LightBulbInfoState();
}

class _LightBulbInfoState extends State<LightBulbInfoWidget> {
  DatabaseProvider dbProvider = DatabaseProvider();
  TasmotaProvider apiProvider = TasmotaProvider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.lightbulb,
                  size: 50,
                  color: widget.lightBulb.power
                      ? Color(0xFFFF9800).withOpacity(0.8)
                      : Colors.white.withOpacity(0.3))),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${widget.lightBulb.label}\n",
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: labelTextStyle,
                ),
                Text("IP: ${widget.lightBulb.ip}\n",
                    maxLines: 1, style: infoTextStyle),
                Text(
                    "Status: ${widget.lightBulb.available ? "available" : "not available"}\n",
                    maxLines: 1,
                    style: infoTextStyle),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: InkWell(
                customBorder: CircleBorder(),
                onTap: () {
                  widget.lightBulb.togglePower();
                  dbProvider.updateLB(widget.lightBulb);
                  apiProvider.togglePower(widget.lightBulb);
                  widget.notifyParent();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: widget.lightBulb.power
                          ? Color(0xFF14CFA2).withOpacity(0.6)
                          : Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.power_settings_new,
                    size: 30,
                    color: widget.lightBulb.power
                        ? Colors.white.withOpacity(0.9)
                        : Colors.white.withOpacity(0.3),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

Color whiteOn = Colors.white.withOpacity(0.9);
Color whiteOff = Colors.white.withOpacity(0.3);
Color greenOn = Color(0xFF14CFA2).withOpacity(0.6);

TextStyle labelTextStyle =
    TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white);
TextStyle infoTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white.withOpacity(0.3));
