import 'package:dartz/dartz.dart';
import 'package:sunofa_map/data/models/adressebook/adresse_book.dto.dart';
import 'package:sunofa_map/data/models/id.dto.dart';

abstract class AdresseBookRepository {
  Future<Either> getAdresseBooks();
  Future<Either> getAdresseBook(IdParms data);
  Future<Either> createAdresseBook(AdresseBookDTO data);
  Future<Either> updateAdresse(AdresseBookDTO data);
}
