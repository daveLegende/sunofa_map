// import 'dart:convert';

// import 'package:dartz/dartz.dart';
// import 'package:tournoi_zemoz/common/api/api.dart';

// import 'package:http/http.dart' as http;
// import 'package:tournoi_zemoz/features/data/models/coupon/coupon.dto.dart';
// import 'package:tournoi_zemoz/features/data/models/user/changepass.dto.dart';
// import 'package:tournoi_zemoz/features/data/models/user/delete_bet_ticket.dto.dart';
// import 'package:tournoi_zemoz/features/data/models/user/update_user.dto.dart';
// import 'package:tournoi_zemoz/features/domain/entities/coupon/coupon_entity.dart';
// import 'package:tournoi_zemoz/features/domain/entities/ticket/ticket.entity.dart';
// // import 'package:tournoi_zemoz/features/data/models/user/user.dto.dart';
// import 'package:tournoi_zemoz/features/domain/entities/user/user_entity.dart';
// import 'package:tournoi_zemoz/services/preferences.dart';

// abstract class UserService {
//   Future<Either> getCurrentUser();
//   Future<Either> getUserTickets();
//   Future<Either> getUserBets();
//   Future<Either> editUser(UpdateUserDTO data);
//   Future<Either> changePass(ChangePassDTO data);
//   Future<Either> deleteUserBet(DeleteBetTicketDTO data);
//   Future<Either> deleteUserTicket(DeleteBetTicketDTO data);
//   Future<Either> parier(CouponDTO data);
// }

// class UserServiceImpl extends UserService {
//   @override
//   Future<Either> getCurrentUser() async {
//     try {
//       final token = await PreferenceServices().getAccessToken();
//       final user = await PreferenceServices().getUserFromPreference();
//       // print(user);
//       // print(token);
//       final response = await http.get(
//         Uri.parse("${APIURL.current}/${user.id}"),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           "Authorization": "Bearer $token",
//         },
//         // body: jsonEncode({
//         //   "id": user.id!,
//         // }),
//       );
//       String message = "";
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         // print("************************${response.body}");
//         UserEntity user = UserEntity.fromJson(data);
//         return Right(user);
//       } else {
//         message = "Une erreur s'est produite";
//         // print("message ${response.statusCode}");
//         return Left(message);
//       }
//     } catch (e) {
//       // print("error $e");
//       return const Left("Problème lié à la connexion, veuillez réessayer");
//     }
//   }

//   @override
//   Future<Either> changePass(ChangePassDTO data) async {
//     try {
//       final token = await PreferenceServices().getAccessToken();
//       final response = await http.post(
//         Uri.parse(APIURL.changePass),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           "Authorization": "Bearer $token",
//         },
//         body: jsonEncode(data.toJson()),
//       );
//       String message = "";
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         UserEntity user = UserEntity.fromJson(data);
//         await PreferenceServices().saveUserInPreferences(user);
//         return Right(user);
//       } else if (response.statusCode == 400) {
//         message = "Nouveau mot de passe incorrecte";
//         return Left(message);
//       } else {
//         message = "Mot de passe incorrecte";
//         return Left(message);
//       }
//     } catch (e) {
//       return const Left("Problème lié à la connexion, veuillez réessayer");
//     }
//   }

//   @override
//   Future<Either> getUserTickets() async {
//     try {
//       final token = await PreferenceServices().getAccessToken();
//       final user = await PreferenceServices().getUserFromPreference();
//       final response = await http.get(
//         Uri.parse("${APIURL.userTickets}/${user.id}"),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           "Authorization": "Bearer $token",
//         },
//         // body: jsonEncode({
//         //   "id": user.id!,
//         // }),
//       );
//       String message = "";
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // final Map<String, dynamic> data = json.decode(response.body);
//         // print("************************${response.body}");
//         List<TicketEntity> tickets = ticketListFromJson(response.body);
//         return Right(tickets);
//       } else {
//         message = "Une erreur s'est produite";
//         // print("message ${response.statusCode}");
//         return Left(message);
//       }
//     } catch (e) {
//       // print("error $e");
//       return const Left("Problème lié à la connexion, veuillez réessayer");
//     }
//   }

//   @override
//   Future<Either> getUserBets() async {
//     try {
//       final token = await PreferenceServices().getAccessToken();
//       final user = await PreferenceServices().getUserFromPreference();
//       final response = await http.get(
//         Uri.parse("${APIURL.userBets}/${user.id}"),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           "Authorization": "Bearer $token",
//         },
//       );
//       String message = "";
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // final Map<String, dynamic> data = json.decode(response.body);
//         // print("************************${response.body}");
//         List<CouponEntity> coupons = couponListFromJson(response.body);
//         return Right(coupons);
//       } else {
//         message = "Une erreur s'est produite";
//         // print("message ${response.statusCode}");
//         return Left(message);
//       }
//     } catch (e) {
//       // print("error $e");
//       return const Left("Problème lié à la connexion, veuillez réessayer");
//     }
//   }

//   @override
//   Future<Either> deleteUserBet(DeleteBetTicketDTO data) async {
//     try {
//       final token = await PreferenceServices().getAccessToken();
//       final response = await http.post(
//         Uri.parse(APIURL.deleteBet),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           "Authorization": "Bearer $token",
//         },
//         body: jsonEncode(data.toJson()),
//       );
//       String message = "";
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         message = "Coupon supprimé avec succès";
//         return Right(message);
//       } else {
//         message = "Une erreur est survenue";
//         // print("message ${response.statusCode}");
//         return Left(message);
//       }
//     } catch (e) {
//       // print("error $e");
//       return const Left("Suppression impossible, veuillez réessayer");
//     }
//   }

//   @override
//   Future<Either> deleteUserTicket(DeleteBetTicketDTO data) async {
//     try {
//       final token = await PreferenceServices().getAccessToken();
//       final response = await http.post(
//         Uri.parse(APIURL.deleteTicket),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           "Authorization": "Bearer $token",
//         },
//         body: jsonEncode(data.toJson()),
//       );
//       String message = "";
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return const Right(true);
//       } else {
//         message = "Une erreur est survenue";
//         // print("message ${response.statusCode}");
//         return Left(message);
//       }
//     } catch (e) {
//       // print("error $e");
//       return const Left("Suppression impossible, veuillez réessayer");
//     }
//   }

//   @override
//   Future<Either> editUser(UpdateUserDTO data) async {
//     try {
//       final token = await PreferenceServices().getAccessToken();
//       final response = await http.patch(
//         Uri.parse(APIURL.userURL),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           "Authorization": "Bearer $token",
//         },
//         body: jsonEncode(data.toJson()),
//       );
//       String message = "";
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         UserEntity user = UserEntity.fromJson(data);
//         await PreferenceServices().saveUserInPreferences(user);
//         message = "Information modifiée avec succès";
//         return Right(message);
//       } else {
//         message = "Une erreur est survenue";
//         // print("message ${response.statusCode}");
//         return Left(message);
//       }
//     } catch (e) {
//       // print("error $e");
//       return const Left(
//           "Modification dinformations utilisateur échouée, veuillez réessayer");
//     }
//   }

//   @override
//   Future<Either> parier(CouponDTO data) async {
//     try {
//       final token = await PreferenceServices().getAccessToken();
//       final response = await http.post(
//         Uri.parse(APIURL.couponsURL),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           "Authorization": "Bearer $token",
//         },
//         body: jsonEncode(data.toJson()),
//       );
//       String message = "";
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         // CouponEntity coupon = CouponEntity.fromJson(data);
//         return const Right("Paris éffectué avec succès");
//       } else if (response.statusCode == 400) {
//         message = "Votre solde est insuffisant";
//         print(response.body);
//         return Left(message);
//       } else {
//         message = "Le montant ne doit pas dépassé 100000frs";
//         print(message);
//         return Left(message);
//       }
//     } catch (e) {
//       print("--------------------$e");
//       return const Left("Impossible de parier, veuillez réessayer");
//     }
//   }
// }
