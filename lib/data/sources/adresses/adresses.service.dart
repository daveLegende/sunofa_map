import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sunofa_map/common/api/api.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/data/models/adresses/adresse.dto.dart';
import 'package:sunofa_map/data/models/id.dto.dart';

import 'package:http/http.dart' as http;
import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';
import 'package:sunofa_map/domain/entities/medias/media_entity.dart';
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
  Future<String> _fetchFileUrl(String? fileName) async {
    if (fileName == null || fileName.isEmpty) {
      return ""; // Retourner une chaîne vide si le fichier n'existe pas
    }

    try {
      final token = await PreferenceServices().getToken();
      final response = await http.get(
        Uri.parse("${APIURL.fileUrl}/$fileName"),
        headers: {
          'Authorization': "Bearer $token",
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "${APIURL.fileUrl}/$fileName"; // Retourner l'URL complet du fichier
      } else {
        throw Exception("Erreur ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Impossible de charger le fichier: $e");
    }
  }

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

      if (data.googleAddress != null)
        request.fields['googleAddress'] = data.googleAddress!;
      if (data.info != null) request.fields['info'] = data.info!;
      if (data.longitude != null)
        request.fields['longitude'] = data.longitude.toString();
      if (data.latitude != null)
        request.fields['latitude'] = data.latitude.toString();
      if (data.codePin != null)
        request.fields['codePin'] = data.codePin.toString();

      Future<void> addFileIfExists(String? path, String fieldName,
          {List<String>? validExtensions}) async {
        if (path != null && path.isNotEmpty && File(path).existsSync()) {
          if (validExtensions != null &&
              !validExtensions.contains(path.split('.').last.toLowerCase())) {
            print("❌ Format invalide pour $fieldName : $path");
            return;
          }
          request.files.add(await http.MultipartFile.fromPath(fieldName, path));
          print("✅ Fichier ajouté pour $fieldName : $path");
        } else {
          print("⚠️ Fichier introuvable ou chemin vide pour $fieldName: $path");
        }
      }

      await addFileIfExists(data.media!.photo1, 'photo1');
      await addFileIfExists(data.media!.photo2, 'photo2');
      await addFileIfExists(data.media!.video1, 'video1');
      await addFileIfExists(data.media!.video2, 'video2');

      if (data.media!.audio1 != null &&
          File(data.media!.audio1!).existsSync()) {
        request.files.add(
            await http.MultipartFile.fromPath('audio1', data.media!.audio1!));
        print("✅ Audio ajouté : ${data.media!.audio1}");
      } else {
        print("⚠️ Aucun fichier audio à ajouter.");
      }

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      print("Response: $responseData");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right("add_address.success_message".tr());
      } else if (response.statusCode == 404) {
        return Left("add_address.failed_message".tr());
      } else {
        return Left("add_address.failed_message".tr());
      }
    } catch (e) {
      print("--------------------$e");
      return Left(
        "add_address.try_message".tr(),
      );
    }
  }

  @override
  Future<Either> getAdresse(IdParms data) {
    // TODO: implement getAdresse
    throw UnimplementedError();
  }

  // @override
  // Future<Either> updateAdresse(AdresseDTO data) async {
  //   try {
  //     final token = await PreferenceServices().getToken();
  //     print("Données envoyées : ${jsonEncode(data.toJsonWithId())}");
  //     final response = await http.put(
  //       Uri.parse("${APIURL.adresses}/${data.id}"),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         "Authorization": "Bearer $token",
  //         // "_method": "PUT",
  //       },
  //       body: jsonEncode(data.toJsonWithId()),
  //     );
  //     String message = "";
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       // final Map<String, dynamic> data = json.decode(response.body);
  //       // CouponEntity coupon = CouponEntity.fromJson(data);
  //       return const Right("Adresse modifiée avec succès");
  //     } else if (response.statusCode == 404) {
  //       message = "Une erreur s''est produite";
  //       print(response.body);
  //       return Left(message);
  //     } else {
  //       message = "Erreur du serveur";
  //       print(response.body);
  //       return Left(message);
  //     }
  //   } catch (e) {
  //     print("--------------------$e");
  //     return const Left("Impossible de modifer l'adresse, veuillez réessayer");
  //   }
  // }

  @override
  Future<Either> updateAdresse(AdresseDTO data) async {
    try {
      final token = await PreferenceServices().getToken();
      var request = http.MultipartRequest(
        'POST', // Utilisez POST pour simuler PUT avec _method=PUT
        Uri.parse("${APIURL.adresses}/${data.id}"),
      );

      // Ajouter les en-têtes
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      // Ajouter le champ _method=PUT pour simuler une requête PUT
      request.fields['_method'] = 'PUT';

      // Ajouter les champs de données
      request.fields['user_id'] = data.user_id.toString();
      request.fields['pseudo'] = data.pseudo.trim();
      request.fields['adressName'] = data.adressName.trim();
      request.fields['city'] = data.city.trim();
      request.fields['info'] = data.info!.trim();
      request.fields['favory'] = data.favory ? "1" : "0";

      if (data.googleAddress != null) {
        request.fields['googleAddress'] = data.googleAddress!;
      }
      if (data.longitude != null) {
        request.fields['longitude'] = data.longitude.toString();
      }
      if (data.latitude != null) {
        request.fields['latitude'] = data.latitude.toString();
      }
      if (data.codePin != null) {
        request.fields['codePin'] = data.codePin.toString();
      }

      // Fonction pour ajouter des fichiers s'ils existent
      Future<void> addFileIfExists(String? path, String fieldName,
          {List<String>? validExtensions}) async {
        if (path != null && path.isNotEmpty && File(path).existsSync()) {
          if (validExtensions != null &&
              !validExtensions.contains(path.split('.').last.toLowerCase())) {
            print("❌ Format invalide pour $fieldName : $path");
            return;
          }
          request.files.add(await http.MultipartFile.fromPath(fieldName, path));
          print("✅ Fichier ajouté pour $fieldName : $path");
        } else {
          print("⚠️ Fichier introuvable ou chemin vide pour $fieldName: $path");
        }
      }

      // Ajouter les fichiers multimédias
      await addFileIfExists(data.media!.photo1, 'photo1');
      await addFileIfExists(data.media!.photo2, 'photo2');
      await addFileIfExists(data.media!.video1, 'video1');
      await addFileIfExists(data.media!.video2, 'video2');

      if (data.media!.audio1 != null &&
          File(data.media!.audio1!).existsSync()) {
        request.files.add(
            await http.MultipartFile.fromPath('audio1', data.media!.audio1!));
        print("✅ Audio ajouté : ${data.media!.audio1}");
      } else {
        print("⚠️ Aucun fichier audio à ajouter.");
      }

      // Envoyer la requête
      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      print("Response: $responseData");

      // Gérer la réponse
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right("Adresse modifiée avec succès");
      } else if (response.statusCode == 404) {
        return Left("Une erreur s'est produite");
      } else {
        return Left("Erreur du serveur");
      }
    } catch (e) {
      print("--------------------$e");
      return const Left("Impossible de modifier l'adresse, veuillez réessayer");
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
