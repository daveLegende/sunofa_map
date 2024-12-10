import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:sunofa_map/common/api/api.dart';
import 'package:sunofa_map/data/models/auth/login.dto.dart';

import 'package:http/http.dart' as http;
import 'package:sunofa_map/data/models/user/user.dto.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/services/preferences.dart';

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
      final response = await http.post(
        Uri.parse(APIURL.users),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data.toJson()),
      );
      String message = "";
      if (response.statusCode == 200 || response.statusCode == 201) {
        // final Map<String, dynamic> data = json.decode(response.body);
        print(response.body);
        return const Right("User register successful");
      } else if (response.statusCode == 409) {
        print(response.body);
        message = "Cet email existe déjâ";
        return Left(message);
      } else if (response.statusCode == 302) {
        print(response.body);
        final redirectUrl = response.headers['location'];
        print('Redirigé vers : $redirectUrl');

        // Faites une nouvelle requête vers l'URL redirigée
        final redirectedResponse = await http.get(Uri.parse(redirectUrl!));
        print('Contenu : ${redirectedResponse.body}');
        login(
          LoginDTO(
            email: data.email,
            password: data.password,
          ),
        );
        return Right(message);
      } else {
        print(response.body);

        message = "Une erreur s'est produite";
        return Left(message);
      }
    } catch (e) {
      return const Left(
        "Erreur lors de la création de compte, veuillez réessayer",
      );
    }
  }
}