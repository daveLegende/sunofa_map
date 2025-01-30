import 'package:dartz/dartz.dart';
import 'package:sunofa_map/core/usecases/usecase.dart';
import 'package:sunofa_map/data/models/adressebook/adresse_book.dto.dart';
import 'package:sunofa_map/domain/repositories/adressebook/adresse_book_repo.dart';
import 'package:sunofa_map/service_locator.dart';

class EditAdresseBookUseCase implements UseCase<Either, AdresseBookDTO> {

  @override
  Future<Either> call({AdresseBookDTO? params}) async {
    return sl<AdresseBookRepository>().updateAdresseBook(params!);
  }

}