// import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';

abstract class ValidatePinState {}


class ValidatePinLoadingState extends ValidatePinState {}

class ValidatePinSuccessState extends ValidatePinState {
  final String message;

  ValidatePinSuccessState({
    required this.message,
  });
}

class ValidatePinFailedState extends ValidatePinState {
  final String message;

  ValidatePinFailedState({
    required this.message,
  });
}
