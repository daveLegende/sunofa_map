// import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';

import 'package:sunofa_map/domain/entities/favories/favories_entity.dart';

abstract class FavoriesState {}


class FavoriesLoadingState extends FavoriesState {}

class FavoriesSuccessState extends FavoriesState {
  final List<FavoriesEntity> favoris;

  FavoriesSuccessState({
    required this.favoris,
  });
}

class FavoriesFailedState extends FavoriesState {
  final String message;

  FavoriesFailedState({
    required this.message,
  });
}
