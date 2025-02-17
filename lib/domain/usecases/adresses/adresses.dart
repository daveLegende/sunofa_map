import 'package:dartz/dartz.dart';
import 'package:sunofa_map/core/usecases/usecase.dart';
import 'package:sunofa_map/data/models/adresses/adresse.dto.dart';
import 'package:sunofa_map/domain/repositories/adresses/adresse_repo.dart';
import 'package:sunofa_map/service_locator.dart';

class AdresseUseCase implements UseCase<Either, AdresseDTO> {

  @override
  Future<Either> call({AdresseDTO? params}) async {
    return sl<AdresseRepository>().getAdresses();
  }

}

class AllAdresseUseCase implements UseCase<Either, AdresseDTO> {

  @override
  Future<Either> call({AdresseDTO? params}) async {
    return sl<AdresseRepository>().getAllAdresses();
  }

}
