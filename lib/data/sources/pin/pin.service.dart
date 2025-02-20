import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:sunofa_map/common/api/api.dart';

import 'package:http/http.dart' as http;
import 'package:sunofa_map/data/models/user/user.dto.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/services/preferences.dart';

abstract class PinService {
  Future<Either> sendPin();
  Future<Either> requestPin();
}

class PinServiceImpl extends PinService {
  @override
  Future<Either> sendPin() async {
    try {
      final token = await PreferenceServices().getToken();
      final user = await PreferenceServices().getUserFromPreference();
      print("------------------------${user.id}");
      // print(token);
      final response = await http.post(
        Uri.parse("${APIURL.notifications}/${user.id}/sendPin"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token",
        },
      );
      String message = "";
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("************************${response.body}");
        // final Map<String, dynamic> data = json.decode(response.body);
        // if (data.containsKey('data') && data['data'] != null) {
        //   UserEntity user = UserEntity.fromJson(data['data']);
        //   return Right(user);
        // } else {
        //   return const Left("Données utilisateur introuvables.");
        // }
        return Right("Pin code send successfully");
      } else {
        message = "Erreur : envoie de code pin échoué";
        print("message ${response.statusCode}");
        return Left(message);
      }
    } catch (e) {
      print("error $e");
      return const Left("Envoie de code pin échoué");
    }
  }

  @override
  Future<Either> requestPin() async {
    try {
      final token = await PreferenceServices().getToken();
      final user = await PreferenceServices().getUserFromPreference();
      final response = await http.put(
        Uri.parse("${APIURL.notifications}/${user.id}/requestPin"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token",
          // "_method": "PUT",
        },
      );
      String message = "";
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("èèèèèèèèèèèèèèèèèèèè${response.body}");
        return Right(message);
      } else {
        final Map<String, dynamic> data = json.decode(response.body);
        message = data['message'];
        print(response.body);
        return Left(message);
      }
    } catch (e) {
      print("--------------------$e");
      return const Left(
        "Demande de d'envoie de code pin échoué",
      );
    }
  }
}
