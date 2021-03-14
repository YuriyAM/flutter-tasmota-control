import 'package:flutter/material.dart';
import 'package:tasmota_control/models/LightBulb.dart';
import 'package:tasmota_control/widgets/list_widgets/LightBulbCardWidget.dart';
import 'package:tasmota_control/widgets/AddLightBulbDialog.dart';
import 'package:tasmota_control/widgets/list_widgets/NothingAddButton.dart';
import 'package:tasmota_control/services/DatabaseProvider.dart';
import 'package:tasmota_control/widgets/list_widgets/decorations.dart';

class LightBulbListPage extends StatefulWidget {
  @override
  _LightBulbListPageState createState() => _LightBulbListPageState();
}

class _LightBulbListPageState extends State<LightBulbListPage> {
  DatabaseProvider dbProvider = DatabaseProvider();
  List<LightBulb> lightBulbs;
  int count = 0;

  Widget _buildItem(BuildContext context, int index) {
    final lightBulb = lightBulbs[index];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
          decoration: lightBulbCardDecoration,
          child: Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              // Removes that item the list on swipe
              dbProvider.deleteLB(lightBulb);
              _updateListView();
              // Remove current SnackBar to avoid queued SnackBars
              Scaffold.of(context).removeCurrentSnackBar();
              // Shows the information on Snackbar
              Scaffold.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.fixed,
                duration: Duration(milliseconds: 3000),
                backgroundColor: Color(0xFF363540).withOpacity(0.95),
                content: Text("«${lightBulb.label}» deleted successfully",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ));
            },
            background: dismissibleBackground,
            child: LightBulbCardWidget(
                lightBulb: lightBulb, notifyParent: () => _updateListView()),
          )),
    );
  }

  _addLightBulb() async {
    final lightBulb = await showDialog<LightBulb>(
        context: context, builder: (_) => new AddLightBulbDialog());
    if (lightBulb != null) {
      await dbProvider.insertLB(lightBulb);
      _updateListView();
    }
  }

  Future<void> _updateListViewAndDatabase() async {
    await dbProvider.initializeDatabase();
    await dbProvider.updateDatabaseFromApi();
    await _updateListView();
  }

  Future<void> _updateListView() async {
    await dbProvider.initializeDatabase();
    var lbFutureList = await dbProvider.getLightbulbList();
    setState(() {
      this.lightBulbs = lbFutureList;
      this.count = lbFutureList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (lightBulbs == null) {
      lightBulbs = List<LightBulb>();
      _updateListView();
    }
    if (lightBulbs.isEmpty) {
      return Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "There is nothing here yet",
                  style: Theme.of(context).textTheme.headline2,
                )),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: NothingAddButton(notifyParent: _addLightBulb))
        ],
      ));
    }
    return Scaffold(
      // appBar: AppBar(),
      body: RefreshIndicator(
          color: Colors.white,
          onRefresh: () => _updateListViewAndDatabase(),
          child: ListView.builder(
            itemBuilder: _buildItem,
            itemCount: lightBulbs.length,
          )),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF363540),
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () => _addLightBulb()),
    );
  }
}
