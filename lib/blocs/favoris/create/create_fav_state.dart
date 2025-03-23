// import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';

abstract class CreateFavoriesState {}


class CreateFavoriesLoadingState extends CreateFavoriesState {}

class CreateFavoriesSuccessState extends CreateFavoriesState {
  final String message;

  CreateFavoriesSuccessState({
    required this.message,
  });
}

class CreateFavoriesFailedState extends CreateFavoriesState {
  final String message;

  CreateFavoriesFailedState({
    required this.message,
  });
}
