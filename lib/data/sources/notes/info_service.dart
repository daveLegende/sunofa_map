// // import 'dart:convert';

// import 'package:dartz/dartz.dart';
// import 'package:tournoi_zemoz/common/api/api.dart';

// import 'package:http/http.dart' as http;
// import 'package:tournoi_zemoz/features/domain/entities/infos/info.entity.dart';

// abstract class InfoService {
//   Future<Either> getInfos();
// }

// // implement

// class InfoServiceImpl extends InfoService {
//   @override
//   Future<Either> getInfos() async {
//     try {
//       final response = await http.get(
//         Uri.parse(APIURL.infosURL),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//         },
//       );
//       String message = "";
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // final Map<String, dynamic> data = json.decode(response.body);
//         List<InfoEntity> infos = infoListJson(response.body);
//         // print(infos);
//         return Right(infos);
//       } else {
//         message = "Une erreur s'est produite";
//         return Left(message);
//       }
//     } catch (e) {
//       return const Left("Problème lié à la connexion, veuillez réessayer");
//     }
//   }
// }
