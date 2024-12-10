import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';

abstract class AdresseState {}


class AdresseLoadingState extends AdresseState {}

class AdresseSuccessState extends AdresseState {
  final List<AdressesEntity> adresses;

  AdresseSuccessState({
    required this.adresses,
  });
}

class AdresseFailedState extends AdresseState {
  final String message;

  AdresseFailedState({
    required this.message,
  });
}
