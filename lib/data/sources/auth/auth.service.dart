import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sunofa_map/common/api/api.dart';
import 'package:sunofa_map/data/models/auth/login.dto.dart';

import 'package:http/http.dart' as http;
import 'package:sunofa_map/data/models/user/user.dto.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/services/preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

abstract class AuthService {
  Future<Either> login(LoginDTO data);
  Future<Either> register(UserDTO data);
}

// implement

class AuthServiceImpl extends AuthService {
  @override
  Future<Either> login(LoginDTO data) async {
    try {
      final response = await http.post(
        Uri.parse(APIURL.login),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'password': data.password,
          'email': data.email,
        }),
      );
      String message = "";
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(response.body);
        // Si votre API renvoie un token, vous pouvez l'utiliser ici
        final String token = data['token'];
        final UserEntity user = UserEntity.fromJson(data['data']);
        await PreferenceServices().setToken(token);

        await PreferenceServices().saveUserInPreferences(user);
        await OneSignal.login(user.id!);
        return Right(user);
      } else if (response.statusCode == 401) {
        message = "Mot de passe entré est incorrecte";
        print(message);
        return Left(message);
      } else if (response.statusCode == 400 ||
          response.statusCode == 404 ||
          response.statusCode == 500) {
        message = "Cet utilisateur n'existe pas, veuillez créer un compte";
        print(message);
        return Left(message);
      } else {
        message = "Une erreur s'est produite";
        print(message);
        print(message);
        return Left(message);
      }
    } catch (e) {
      print(e);
      return const Left("Erreur lors de la connexion, veuillez réessayer");
    }
  }

  @override
  Future<Either> register(UserDTO data) async {
    try {
      print(data);
      final response = await http.post(
        Uri.parse(APIURL.users),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data.toRegisterJson()),
      );
      String message = "";
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        login(
          LoginDTO(
            email: data.email,
            password: data.password,
          ),
        );
        return const Right("User register successful");
      } else {
        // Convertir la réponse en un objet Map
        final Map<String, dynamic> responseJson = json.decode(response.body);

        // Extraire le message
        final String message = responseJson['message'] ?? 'Erreur inconnue';
        return Left(message);
      }
    } catch (e) {
      print(e.toString());
      return Left(
        "register.try_error".tr(),
      );
    }
  }
}
