import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:sunofa_map/common/api/api.dart';
import 'package:sunofa_map/data/models/adresses/adresse.dto.dart';
import 'package:sunofa_map/data/models/id.dto.dart';

import 'package:http/http.dart' as http;
import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';
import 'package:sunofa_map/services/preferences.dart';

abstract class AdresseService {
  Future<Either> getAdresses();
  Future<Either> getAdresse(IdParms data);
  Future<Either> createAdresse(AdresseDTO data);
  Future<Either> updateAdresse(AdresseDTO data);
  Future<Either> deleteAdresse(IdParms data);
}

class AdresseServiceImpl extends AdresseService {
  @override
  Future<Either> getAdresses() async {
    try {
      final token = await PreferenceServices().getToken();
      final user = await PreferenceServices().getUserFromPreference();
      final response = await http.get(
        Uri.parse(APIURL.adresses),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
      );
      String message = "";
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("************************${response.body}");
        List<AdressesEntity> adresses = adressesListJson(response.body);
        final add = adresses
            .where(
              (element) => element.user.id == user.id,
            )
            .toList();
        return Right(add);
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
  Future<Either> createAdresse(AdresseDTO data) async {
    try {
      final token = await PreferenceServices().getToken();
      final response = await http.post(
        Uri.parse(APIURL.adresses),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(data.toJson()),
      );
      String message = "";
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 302) {
        // final Map<String, dynamic> data = json.decode(response.body);
        print(response.body);
        // CouponEntity coupon = CouponEntity.fromJson(data);
        return const Right("Adresse ajoutée avec succès");
      } else if (response.statusCode == 404) {
        message = "Une erreur s''est produite";
        print(response.body);
        return Left(message);
      } else {
        message = "Erreur du serveur";
        print(response.body);
        return Left(message);
      }
    } catch (e) {
      print("--------------------$e");
      return const Left("Impossible de créer cet adresse, veuillez réessayer");
    }
  }

  @override
  Future<Either> getAdresse(IdParms data) {
    // TODO: implement getAdresse
    throw UnimplementedError();
  }

  @override
  Future<Either> updateAdresse(AdresseDTO data) async {
    try {
      final token = await PreferenceServices().getToken();
      print("Données envoyées : ${jsonEncode(data.toJsonWithId())}");
      final response = await http.put(
        Uri.parse("${APIURL.adresses}/${data.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token",
          // "_method": "PUT",
        },
        body: jsonEncode(data.toJsonWithId()),
      );
      String message = "";
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 302) {
        // final Map<String, dynamic> data = json.decode(response.body);
        // CouponEntity coupon = CouponEntity.fromJson(data);
        return const Right("Adresse modifiée avec succès");
      } else if (response.statusCode == 404) {
        message = "Une erreur s''est produite";
        print(response.body);
        return Left(message);
      } else {
        message = "Erreur du serveur";
        print(response.body);
        return Left(message);
      }
    } catch (e) {
      print("--------------------$e");
      return const Left("Impossible de modifer l'adresse, veuillez réessayer");
    }
  }

  @override
  Future<Either> deleteAdresse(IdParms data) async {
    try {
      final token = await PreferenceServices().getToken();
      // final user = await PreferenceServices().getUserFromPreference();
      final response = await http.delete(
        Uri.parse("${APIURL.adresses}/${data.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(data.toJson()),
      );
      String message = "";
      print("message ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(true);
      } else {
        message = "Une erreur est survenue";
        print("message ${response.statusCode}");
        return Left(message);
      }
    } catch (e) {
      // print("error $e");
      return const Left("Suppression impossible, veuillez réessayer");
    }
  }
}
