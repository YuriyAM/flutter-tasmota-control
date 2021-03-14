import 'package:flutter/cupertino.dart';
import 'package:tasmota_control/viewmodels/LightBulbVM.dart';

class LightBulbListVM extends ChangeNotifier {
  Map<LightBulbVM, int> lightBulbList = Map<LightBulbVM, int>();

  void removeFromList(LightBulbVM lightBulb) {
    this.lightBulbList.remove(lightBulb);
    notifyListeners();
  }
}
