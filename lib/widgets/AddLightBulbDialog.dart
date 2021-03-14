import 'package:flutter/material.dart';
import 'package:tasmota_control/models/LightBulb.dart';
import 'package:tasmota_control/services/TasmotaProvider.dart';

class AddLightBulbDialog extends StatelessWidget {
  final TextEditingController controllerLabel = new TextEditingController();
  final TextEditingController controllerIP = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool check = false;
    TasmotaProvider apiProvider = TasmotaProvider();

    return AlertDialog(
      backgroundColor: Color(0xFF232323),
      title: Text("New Light Bulb", style: TextStyle(color: Colors.white)),
      content: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: textDecoration("Label"),
              controller: controllerLabel,
              autofocus: true,
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: TextStyle(color: Colors.white),
            controller: controllerIP,
            decoration: textDecoration("IP Address"),
            keyboardType: TextInputType.number,
            validator: (String value) {
              ipRegExp.hasMatch(value) ? check = true : check = false;
              return check ? null : "Invalid IP Address";
            },
          ),
        ]),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('Add'),
          onPressed: () async {
            if (!check) return;
            var a = await apiProvider.checkAvailable(controllerIP.value.text);
            final lightBulb = new LightBulb(
                label: controllerLabel.value.text,
                ip: controllerIP.value.text,
                available: a);
            controllerLabel.clear();
            controllerIP.clear();
            Navigator.of(context).pop(lightBulb);
          },
        ),
      ],
    );
  }
}

RegExp ipRegExp =
    RegExp(r"^((25[0-5]|(2[0-4]|1[0-9]|[1-9]|)[0-9])(\.(?!$)|$)){4}$");

InputDecoration textDecoration(String label) {
  return InputDecoration(
    labelText: label,
    enabledBorder: UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.white54, width: 0.0),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.white54, width: 0.0),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 0.0),
    ),
  );
}
