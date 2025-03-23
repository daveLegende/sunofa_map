import 'package:dartz/dartz.dart';
import 'package:sunofa_map/core/usecases/usecase.dart';
import 'package:sunofa_map/data/models/favories/favories.dto.dart';
import 'package:sunofa_map/domain/repositories/favories/favories_repository.dart';
import 'package:sunofa_map/service_locator.dart';

class CreateFavorisUseCase implements UseCase<Either, FavoriesDTO> {

  @override
  Future<Either> call({FavoriesDTO? params}) async {
    return sl<FavoriesRepository>().createFavory(params!);
  }

}
