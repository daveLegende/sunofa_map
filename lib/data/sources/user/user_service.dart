import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:sunofa_map/common/api/api.dart';

import 'package:http/http.dart' as http;
import 'package:sunofa_map/data/models/user/user.dto.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/services/preferences.dart';
abstract class UserService {
  Future<Either> getCurrentUser();
  Future<Either> editUser(UserDTO data);
  Future<Either> changePass(UserDTO data);
}

class UserServiceImpl extends UserService {
  @override
  Future<Either> getCurrentUser() async {
    try {
      final token = await PreferenceServices().getToken();
      final user = await PreferenceServices().getUserFromPreference();
      print("------------------------${user.id}");
      // print(token);
      final response = await http.get(
        Uri.parse("${APIURL.users}/${user.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
      );
      String message = "";
      if (response.statusCode == 200 || response.statusCode == 201) {
        // print("************************${response.body}");
        final Map<String, dynamic> data = json.decode(response.body);
        UserEntity user = UserEntity.fromJson(data['data']);
        // print("************************${user.name}");
        return Right(user);
      } else {
        message = "Une erreur s'est produite";
        print("message ${response.statusCode}");
        return Left(message);
      }
    } catch (e) {
      print("error $e");
      return const Left("Problème lié à la connexion, veuillez réessayer");
    }
  }
  
  @override
  Future<Either> changePass(UserDTO data) {
    // TODO: implement changePass
    throw UnimplementedError();
  }
  
  @override
  Future<Either> editUser(UserDTO data) {
    // TODO: implement editUser
    throw UnimplementedError();
  }

  // @override
  // Future<Either> changePass(UserDTO data) async {
    // try {
    //   final token = await PreferenceServices().getAccessToken();
    //   final response = await http.post(
    //     Uri.parse(APIURL.changePass),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json',
    //       "Authorization": "Bearer $token",
    //     },
    //     body: jsonEncode(data.toJson()),
    //   );
    //   String message = "";
    //   if (response.statusCode == 200 || response.statusCode == 201) {
    //     final Map<String, dynamic> data = json.decode(response.body);
    //     UserEntity user = UserEntity.fromJson(data);
    //     await PreferenceServices().saveUserInPreferences(user);
    //     return Right(user);
    //   } else if (response.statusCode == 400) {
    //     message = "Nouveau mot de passe incorrecte";
    //     return Left(message);
    //   } else {
    //     message = "Mot de passe incorrecte";
    //     return Left(message);
    //   }
    // } catch (e) {
    //   return const Left("Problème lié à la connexion, veuillez réessayer");
    // }
  // }

  // @override
  // Future<Either> editUser(UpdateUserDTO data) async {
    // try {
    //   final token = await PreferenceServices().getAccessToken();
    //   final response = await http.patch(
    //     Uri.parse(APIURL.userURL),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json',
    //       "Authorization": "Bearer $token",
    //     },
    //     body: jsonEncode(data.toJson()),
    //   );
    //   String message = "";
    //   if (response.statusCode == 200 || response.statusCode == 201) {
    //     final Map<String, dynamic> data = json.decode(response.body);
    //     UserEntity user = UserEntity.fromJson(data);
    //     await PreferenceServices().saveUserInPreferences(user);
    //     message = "Information modifiée avec succès";
    //     return Right(message);
    //   } else {
    //     message = "Une erreur est survenue";
    //     // print("message ${response.statusCode}");
    //     return Left(message);
    //   }
    // } catch (e) {
    //   // print("error $e");
    //   return const Left(
    //       "Modification dinformations utilisateur échouée, veuillez réessayer");
    // }
  // }
}
