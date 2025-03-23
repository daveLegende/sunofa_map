import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:sunofa_map/common/api/api.dart';
import 'package:sunofa_map/data/models/favories/favories.dto.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/domain/entities/favories/favories_entity.dart';
import 'package:sunofa_map/services/preferences.dart';

import 'package:http/http.dart' as http;

abstract class FavoriesService {
  Future<Either> getFavories();
  Future<Either> createFavorie(FavoriesDTO data);
  Future<Either> updateFavorie(FavoriesDTO data);
  Future<Either> deleteFavorie(IdParms data);
}

class FavoriesServiceImpl extends FavoriesService {
  @override
  Future<Either> getFavories() async {
    try {
      final token = await PreferenceServices().getToken();
      final response = await http.get(
        Uri.parse(APIURL.favories),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token",
        },
      );
      String message = "";
      if (response.statusCode == 200 || response.statusCode == 201) {
        // print("************************${response.body}");
        List<FavoriesEntity> fav = favListJson(response.body);
        return Right(fav);
      } else {
        message = "Une erreur s'est produite";
        // print("message ${response.statusCode}");
        return Left(message);
      }
    } catch (e) {
      print("error $e");
      return const Left("Problème lié à la connexion, veuillez réessayer");
    }
  }

  @override
  Future<Either> createFavorie(FavoriesDTO data) async {
    try {
      final token = await PreferenceServices().getToken();
      final response = await http.post(
        Uri.parse(APIURL.favories),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(data.toJson()),
      );
      String message = "";
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        return const Right("Adresse ajouté dans les favoris avec succès");
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
      return const Left("Impossible d'ajouter l'adresse aux favoris', veuillez réessayer");
    }
  }

  @override
  Future<Either> deleteFavorie(IdParms data) async {
    try {
      final token = await PreferenceServices().getToken();
      // final user = await PreferenceServices().getUserFromPreference();
      final response = await http.delete(
        Uri.parse("${APIURL.favories}/${data.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(data.toJson()),
      );
      String message = "";
      print("message ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right("Adresse retirée des favoris");
      } else {
        message = "Une erreur est survenue";
        print("message ${response.statusCode}");
        return Left(message);
      }
    } catch (e) {
      // print("error $e");
      return const Left("impossible de retirée l'adresse des favoris, veuillez réessayer");
    }
  }

  @override
  Future<Either> updateFavorie(FavoriesDTO data) {
    // TODO: implement updateFavorie
    throw UnimplementedError();
  }
}
