import 'package:dartz/dartz.dart';
import 'package:sunofa_map/data/models/adresses/adresse.dto.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/data/sources/adresses/adresses.service.dart';
import 'package:sunofa_map/domain/repositories/adresses/adresse_repo.dart';
import 'package:sunofa_map/service_locator.dart';

class AdresseRepositoryImpl extends AdresseRepository {
  @override
  Future<Either> getAdresses() async {
    return await sl<AdresseService>().getAdresses();
  }

  @override
  Future<Either> createAdresse(AdresseDTO data) async {
    return await sl<AdresseService>().createAdresse(data);
  }

  @override
  Future<Either> getAdresse(IdParms data) {
    // TODO: implement getAdresse
    throw UnimplementedError();
  }

  @override
  Future<Either> updateAdresse(AdresseDTO data) async {
    return await sl<AdresseService>().updateAdresse(data);
  }

  @override
  Future<Either> deleteAdresse(IdParms data) async {
    return await sl<AdresseService>().deleteAdresse(data);
  }

  @override
  Future<Either> getAllAdresses() async {
    return await sl<AdresseService>().getAllAdresses();
  }
}
