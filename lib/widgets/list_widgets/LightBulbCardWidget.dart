import 'package:flutter/material.dart';
import 'package:tasmota_control/models/LightBulb.dart';
import 'package:tasmota_control/pages/LightBulbPage.dart';
import 'package:tasmota_control/services/DatabaseProvider.dart';
import 'package:tasmota_control/services/TasmotaProvider.dart';

class LightBulbCardWidget extends StatefulWidget {
  final LightBulb lightBulb;
  final Function notifyParent;
  LightBulbCardWidget({Key key, this.lightBulb, @required this.notifyParent})
      : super(key: key);
  @override
  _LightBulbCardState createState() => _LightBulbCardState();
}

class _LightBulbCardState extends State<LightBulbCardWidget> {
  DatabaseProvider dbProvider = DatabaseProvider();
  TasmotaProvider apiProvider = TasmotaProvider();

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        customBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onTap: () {
          if (!widget.lightBulb.available) return;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LightBulbPage(lightBulb: widget.lightBulb);
                },
                settings: RouteSettings(name: '/LightBulbPage'),
              )).then((value) => widget.notifyParent());
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Color(0xFF363540).withOpacity(0.95),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.lightbulb,
                        size: 50,
                        color: widget.lightBulb.power
                            ? Color(0xFFFEA92B).withOpacity(0.8)
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
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "IP: ${widget.lightBulb.ip}\n",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      Text(
                        "Status: ${widget.lightBulb.available ? "available" : "not available"}\n",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: InkWell(
                      customBorder: CircleBorder(),
                      onTap: () {
                        if (!widget.lightBulb.available) return;
                        widget.lightBulb.togglePower();
                        dbProvider.updateLB(widget.lightBulb);
                        apiProvider.togglePower(widget.lightBulb);
                        setState(() {});
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
          ),
        ),
      ),
    );
  }
}

Color whiteOn = Colors.white.withOpacity(0.9);
Color whiteOff = Colors.white.withOpacity(0.3);
Color greenOn = Color(0xFF14CFA2).withOpacity(0.6);
