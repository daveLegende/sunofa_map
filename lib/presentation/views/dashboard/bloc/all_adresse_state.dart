import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';

abstract class AllAdresseState {}


class AllAdresseLoadingState extends AllAdresseState {}

class AllAdresseSuccessState extends AllAdresseState {
  final List<AdressesEntity> adresses;

  AllAdresseSuccessState({
    required this.adresses,
  });
}

class AllAdresseFailedState extends AllAdresseState {
  final String message;

  AllAdresseFailedState({
    required this.message,
  });
}
