// import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';

abstract class CreateAdresseState {}


class CreateAdresseLoadingState extends CreateAdresseState {}

class CreateAdresseSuccessState extends CreateAdresseState {
  final String message;

  CreateAdresseSuccessState({
    required this.message,
  });
}

class CreateAdresseFailedState extends CreateAdresseState {
  final String message;

  CreateAdresseFailedState({
    required this.message,
  });
}
