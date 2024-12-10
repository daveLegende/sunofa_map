// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
// import 'package:zemoz/helpers/style.dart';
// import 'package:zemoz/helpers/constant.dart';

// abstract class BaseState<T extends StatefulWidget> extends State<T> {
//   bool isConnectToInternet = true;
//   StreamSubscription? internetConnectionStreamSubscription;
//   bool isDialogShowing = false;

//   @override
//   void initState() {
//     super.initState();
//     // Écouter les changements de statut de la connexion Internet
//     internetConnectionStreamSubscription =
//         InternetConnection().onStatusChange.listen((event) {
//       // Si la connexion est perdue, afficher le dialogue
//       if (event == InternetStatus.disconnected) {
//         showNoConnectionDialog();
//         setState(() {
//           isConnectToInternet = false;
//         });
//       } else if (event == InternetStatus.connected) {
//         // Si la connexion est rétablie, fermer le dialogue
//         if (isDialogShowing) {
//           Navigator.of(context, rootNavigator: true).pop();
//           isDialogShowing = false;
//         }
//         setState(() {
//           isConnectToInternet = true;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     internetConnectionStreamSubscription?.cancel();
//     super.dispose();
//   }

//   void showNoConnectionDialog() {
//     isDialogShowing = true;
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.wifi_off, color: mblack),
//               const SizedBox(width: 10),
//               Text('No Internet', style: StyleText().transStyle),
//             ],
//           ),
//           content: Text(
//             'Veuillez vérifier votre connexion internet puis réessayer.',
//             style: StyleText().googleTitre,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // Navigator.of(context).pop();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     ).then((_) {
//       // Lorsque le dialogue est fermé, mettre à jour le statut
//       isDialogShowing = false;
//     });
//   }

//   // Optionnel: Fonction pour afficher un bottom sheet
//   void showNoConnectionBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       isDismissible: false,
//       builder: (BuildContext context) {
//         return Container(
//           padding: const EdgeInsets.all(16.0),
//           height: MediaQuery.of(context).size.width / 2,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text('No Internet Connection',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               const Text('Please check your internet connection.'),
//               const SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
