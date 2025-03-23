import 'package:dartz/dartz.dart';
import 'package:sunofa_map/data/models/favories/favories.dto.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/data/sources/favories/favories.service.dart';
import 'package:sunofa_map/domain/repositories/favories/favories_repository.dart';
import 'package:sunofa_map/service_locator.dart';

class FavoriesRepositoryImpl extends FavoriesRepository {
  @override
  Future<Either> getFavories() async {
    return await sl<FavoriesService>().getFavories();
  }

  @override
  Future<Either> createFavory(FavoriesDTO data) async {
    return await sl<FavoriesService>().createFavorie(data);
  }

  @override
  Future<Either> deleteFavory(IdParms data) async {
    return await sl<FavoriesService>().deleteFavorie(data);
  }

  @override
  Future<Either> updateFavory(FavoriesDTO data) async {
    return await sl<FavoriesService>().updateFavorie(data);
  }
}
