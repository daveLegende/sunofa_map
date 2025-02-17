import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sunofa_map/common/api/api.dart';
import 'package:sunofa_map/data/models/adresses/adresse.dto.dart';
import 'package:sunofa_map/data/models/id.dto.dart';

import 'package:http/http.dart' as http;
import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';
import 'package:sunofa_map/services/preferences.dart';
import 'package:mime/mime.dart';

abstract class AdresseService {
  Future<Either> getAdresses();
  Future<Either> getAllAdresses();
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
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );
      String message = "";
      print("************************${response.body}");
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
        print("message ${response.body}");
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
      var request = http.MultipartRequest('POST', Uri.parse(APIURL.adresses));

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      request.fields['user_id'] = data.user_id.toString();
      request.fields['pseudo'] = data.pseudo.trim();
      request.fields['adressName'] = data.adressName.trim();
      request.fields['city'] = data.city.trim();
      request.fields['info'] = data.info!.trim();
      request.fields['longitude'] = data.longitude.toString();
      request.fields['latitude'] = data.latitude.toString();
      request.fields['codePin'] = data.codePin.toString().trim().isEmpty
          ? "0"
          : data.codePin.toString().trim();

      // ✅ Vérification avant d'ajouter un fichier
      Future<void> addFileIfExists(String? path, String fieldName,
          {List<String>? validExtensions}) async {
        if (path != null && path.isNotEmpty && File(path).existsSync()) {
          // Vérifie si l'extension du fichier est valide
          if (validExtensions != null &&
              !validExtensions.contains(path.split('.').last.toLowerCase())) {
            print("❌ Format invalide pour $fieldName : $path");
            return;
          }
          request.files.add(await http.MultipartFile.fromPath(fieldName, path));
        } else {
          print("⚠️ Fichier introuvable ou chemin vide pour $fieldName: $path");
        }
      }

      // ✅ Ajout sécurisé des fichiers
      await addFileIfExists(data.media!.photo1, 'photo1');
      await addFileIfExists(data.media!.photo2, 'photo2');
      await addFileIfExists(data.media!.video1, 'video1');
      await addFileIfExists(data.media!.video2, 'video2');
      await addFileIfExists(
        data.media!.audio1,
        'audio1',
        validExtensions: ['mp3', 'wav', 'ogg', 'm4a'],
      );
      // await addFileIfExists(data.media!.audio2, 'audio2');

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      print("Response: $responseData");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right("Adresse ajoutée avec succès");
      } else if (response.statusCode == 404) {
        return Left("Une erreur s'est produite");
      } else {
        return Left("Erreur du serveur");
      }
    } catch (e) {
      print("--------------------$e");
      return const Left(
          "Impossible de créer cette adresse, veuillez réessayer");
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
          'Accept': 'application/json',
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

  @override
  Future<Either> getAllAdresses() async {
    try {
      final token = await PreferenceServices().getToken();
      final user = await PreferenceServices().getUserFromPreference();
      final response = await http.get(
        Uri.parse(APIURL.adresses),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );
      String message = "";
      print("************************${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("************************${response.body}");
        List<AdressesEntity> adresses = adressesListJson(response.body);
        return Right(adresses);
      } else {
        message = "Une erreur s'est produite";
        print("message ${response.body}");
        return Left(message);
      }
    } catch (e) {
      print("error $e");
      return const Left("Problème lié à la connexion, veuillez réessayer");
    }
  }
}
