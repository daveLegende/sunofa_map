import 'package:dartz/dartz.dart';
import 'package:sunofa_map/data/models/adressebook/adresse_book.dto.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/data/sources/adressebook/adresse_book_service.dart';
import 'package:sunofa_map/domain/repositories/adressebook/adresse_book_repo.dart';
import 'package:sunofa_map/service_locator.dart';

class AdresseBookRepositoryImpl extends AdresseBookRepository {
  @override
  Future<Either> getAdresseBooks() async {
    return await sl<AdresseBookService>().getAdresseBooks();
  }

  @override
  Future<Either> createAdresseBook(AdresseBookDTO data) async {
    return await sl<AdresseBookService>().createAdresseBook(data);
  }

  @override
  Future<Either> getAdresseBook(IdParms data) {
    // TODO: implement getAdresse
    throw UnimplementedError();
  }

  @override
  Future<Either> updateAdresseBook(AdresseBookDTO data) async {
    return await sl<AdresseBookService>().updateAdresseBook(data);
  }

  @override
  Future<Either> deleteAdresseBook(IdParms data) async {
    return await sl<AdresseBookService>().deleteAdresseBook(data);
  }
}
