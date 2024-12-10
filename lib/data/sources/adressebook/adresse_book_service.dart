// import 'dart:convert';

// import 'package:dartz/dartz.dart';
// import 'package:tournoi_zemoz/common/api/api.dart';

// import 'package:http/http.dart' as http;
// import 'package:tournoi_zemoz/features/data/models/forgotpass/forgotpass.dto.dart';
// import 'package:tournoi_zemoz/services/preferences.dart';

// abstract class ForgotPassService {
//   Future<Either> sendEmail(ForgotPassDTO data);
//   Future<Either> verifyCode(ForgotPassDTO data);

//   Future<Either> changePass(ReinitialisePassDTO data);
// }

// class ForgotPassServiceImpl extends ForgotPassService {
//   @override
//   Future<Either> changePass(ReinitialisePassDTO data) async {
//     try {
//       final token = await PreferenceServices().getAccessToken();
//       final response = await http.post(
//         Uri.parse(APIURL.reinitialisePass),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           "Authorization": "Bearer $token",
//         },
//         body: jsonEncode(data.toJson()),
//       );
//       String message = "";
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         message = "Mot de passe réinitialisé avec succès";
//         // print(response.body);
//         return Right(message);
//       } else {
//         message = "Une erreur est survenue, réessayez";
//         // print("message ${response.statusCode}");
//         return Left(message);
//       }
//     } catch (e) {
//       // print("error $e");
//       return const Left(
//         "Réinitialisation du mot de passe échouée, veuillez réessayer",
//       );
//     }
//   }

//   @override
//   Future<Either> sendEmail(ForgotPassDTO data) async {
//     try {
//       final token = await PreferenceServices().getAccessToken();
//       final response = await http.post(
//         Uri.parse(APIURL.forgotpassURL),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           "Authorization": "Bearer $token",
//         },
//         body: jsonEncode(data.toJson()),
//       );
//       String message = "";
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         message = "Code envoyé sur ${data.email} avec succès";
//         // print(response.body);
//         return Right(message);
//       } else {
//         message = "Code non envoyé, réessayez";
//         // print("message ${response.statusCode}");
//         return Left(message);
//       }
//     } catch (e) {
//       // print("error $e");
//       return const Left(
//         "Impossible d'envoyer l'email contenant le code, veuillez réessayer",
//       );
//     }
//   }

//   @override
//   Future<Either> verifyCode(ForgotPassDTO data) async {
//     try {
//       final token = await PreferenceServices().getAccessToken();
//       final response = await http.post(
//         Uri.parse(APIURL.verifyEmailCode),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           "Authorization": "Bearer $token",
//         },
//         body: jsonEncode(data.toJson()),
//       );
//       String message = "";
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         message = "Code correcte, veuillez réinitialiser votre mot de passe";
//         // print(response.body);
//         return Right(message);
//       } else {
//         message = "Le code saisi est incorrecte";
//         // print("message ${response.statusCode}");
//         return Left(message);
//       }
//     } catch (e) {
//       // print("error $e");
//       return const Left(
//         "Le code saisi est incorrecte, veuillez réessayer",
//       );
//     }
//   }
// }
