import 'package:flutter/material.dart';
import 'package:tasmota_control/models/LightBulb.dart';
import 'package:tasmota_control/widgets/page_widgets/LightBulbInfoWidget.dart';
import 'package:tasmota_control/widgets/page_widgets/LightBulbColorWidget.dart';
import 'package:tasmota_control/widgets/page_widgets/LightBulbSaturationWidget.dart';
import 'package:tasmota_control/widgets/page_widgets/LightBulbBrightnessWidget.dart';
import 'package:tasmota_control/widgets/page_widgets/DeleteButton.dart';
import 'package:tasmota_control/services/DatabaseProvider.dart';

class LightBulbPage extends StatefulWidget {
  final LightBulb lightBulb;
  LightBulbPage({this.lightBulb});
  @override
  _LightBulbPageState createState() => _LightBulbPageState();
}

class _LightBulbPageState extends State<LightBulbPage> {
  final GlobalKey<_LightBulbPageState> _keyColor = GlobalKey();
  final GlobalKey<_LightBulbPageState> _keyBrightness = GlobalKey();
  DatabaseProvider dbProvider = DatabaseProvider();
  LightBulb lightBulb;

  @override
  Widget build(BuildContext context) {
    if (lightBulb == null) {
      lightBulb = widget.lightBulb;
      _updatePageView();
    }
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("\"${widget.lightBulb.label}\" Light Bulb"),
        centerTitle: true,
        textTheme: Theme.of(context).textTheme,
      ),
      body: RefreshIndicator(
        color: Colors.white,
        onRefresh: () async {
          await dbProvider.updateLightBulbFromApi(widget.lightBulb);
          _updatePageView();
        },
        child: ListView(
          children: <Widget>[
            LightBulbInfoWidget(
              lightBulb: lightBulb,
              notifyParent: () => this.setState(() {}),
            ),
            LightBulbColorWidget(
                key: _keyColor,
                lightBulb: lightBulb,
                notifyParent: () => this.setState(() {})),
            LightBulbSaturationWidget(lightBulb: lightBulb),
            LightBulbBrightnessWidget(
                key: _keyBrightness,
                lightBulb: lightBulb,
                notifyParent: () => this.setState(() {})),
            DeleteButton(lightBulb: lightBulb),
          ],
        ),
      ),
    );
  }

  Future<void> _updatePageView() async {
    await dbProvider.initializeDatabase();
    var lbFuture = await dbProvider.getLightbulb(widget.lightBulb);
    setState(() => this.lightBulb = lbFuture);
  }
}
