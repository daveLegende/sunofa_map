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
}

class AdresseServiceImpl extends AdresseService {
  @override
  Future<Either> getAdresses() async {
    try {
      final token = await PreferenceServices().getToken();
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
        return Right(adresses);
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
  Future<Either> createAdresse(AdresseDTO data) {
    // TODO: implement createAdresse
    throw UnimplementedError();
  }
  
  @override
  Future<Either> getAdresse(IdParms data) {
    // TODO: implement getAdresse
    throw UnimplementedError();
  }
  
  @override
  Future<Either> updateAdresse(AdresseDTO data) {
    // TODO: implement updateAdresse
    throw UnimplementedError();
  }
}
