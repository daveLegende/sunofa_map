import 'package:dartz/dartz.dart';
import 'package:sunofa_map/core/usecases/usecase.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/domain/repositories/adressebook/adresse_book_repo.dart';
import 'package:sunofa_map/service_locator.dart';

class DeleteAdresseBookUseCase implements UseCase<Either, IdParms> {

  @override
  Future<Either> call({IdParms? params}) async {
    return sl<AdresseBookRepository>().deleteAdresseBook(params!);
  }

}