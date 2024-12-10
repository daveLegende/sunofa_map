import 'package:dartz/dartz.dart';
import 'package:sunofa_map/data/models/adresses/adresse.dto.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/data/sources/adresses/adresses_service.dart';
import 'package:sunofa_map/domain/repositories/adresses/adresse_repo.dart';
import 'package:sunofa_map/service_locator.dart';

class AdresseRepositoryImpl extends AdresseRepository {
  @override
  Future<Either> getAdresses() async {
    return await sl<AdresseService>().getAdresses();
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
