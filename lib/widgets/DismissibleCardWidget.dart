// import 'package:flutter/cupertino.dart';
// import 'package:tasmota_control/models/LightBulb.dart';

// class DismissibleCardWidget extends StatefulWidget {
//   final LightBulb lightBulb;
//   DismissibleCardWidget({this.lightBulb});
//   @override
//   _DismissibleCardState createState() => _DismissibleCardState();
// }

//   class _DismissibleCardState extends State<DismissibleCardWidget> {
//     @override
//     Widget build(BuildContext context){
//       return Dismissible(
//         key: UniqueKey(),
//         direction: DismissDirection.endToStart,
//         onDismissed: (direction) {
//           // Removes that item the list on swipe
//           setState(() => lightBulbs.remove(lightBulb));
//           print(lightBulbs);
//           // Remove current SnackBar to avoid queued SnackBars
//           Scaffold.of(context).removeCurrentSnackBar();
//           // Shows the information on Snackbar
//           Scaffold.of(context).showSnackBar(
//             SnackBar(
//               behavior: SnackBarBehavior.fixed,
//               duration: Duration(
//                 milliseconds: 3000,
//               ),
//               backgroundColor: Color(0xFF18202C).withOpacity(0.95),
//               content: Text(
//                 "«${lightBulb.label}» deleted successfully",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//           );
//         },
//         background: Container(
//           alignment: Alignment.centerRight,
//           padding: EdgeInsets.symmetric(
//             vertical: 5,
//             horizontal: 10,
//           ),
//           child: Icon(
//             Icons.delete_forever,
//             size: 50,
//             color: Colors.white.withOpacity(0.5),
//           ),
//         ),
//         child: LightBulbCardWidget(lightBulb: lightBulb),
//       ),
//     }
//   }
