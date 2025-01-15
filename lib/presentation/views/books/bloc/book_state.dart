import 'package:sunofa_map/domain/entities/adressebook/adresse_book.entity.dart';

abstract class BookState {}


class BookLoadingState extends BookState {}

class BookSuccessState extends BookState {
  final List<AdresseBookEntity> books;

  BookSuccessState({
    required this.books,
  });
}

class BookFailedState extends BookState {
  final String message;

  BookFailedState({
    required this.message,
  });
}
