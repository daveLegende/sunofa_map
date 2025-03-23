import 'package:dartz/dartz.dart';
import 'package:sunofa_map/data/models/favories/favories.dto.dart';
import 'package:sunofa_map/data/models/id.dto.dart';

abstract class FavoriesRepository {
  Future<Either> getFavories();
  Future<Either> deleteFavory(IdParms data);
  Future<Either> createFavory(FavoriesDTO data);
  Future<Either> updateFavory(FavoriesDTO data);
}