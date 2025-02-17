import 'package:dartz/dartz.dart';
import 'package:sunofa_map/data/models/adresses/adresse.dto.dart';
import 'package:sunofa_map/data/models/id.dto.dart';

abstract class AdresseRepository {
  Future<Either> getAdresses();
  Future<Either> getAllAdresses();
  Future<Either> getAdresse(IdParms data);
  Future<Either> createAdresse(AdresseDTO data);
  Future<Either> updateAdresse(AdresseDTO data);
  Future<Either> deleteAdresse(IdParms data);
}
