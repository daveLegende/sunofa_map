import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';

abstract class SendPinState {}


class SendPinLoadingState extends SendPinState {}

class SendPinSuccessState extends SendPinState {
  final AdressesEntity adresse;

  SendPinSuccessState({
    required this.adresse,
  });
}

class SendPinFailedState extends SendPinState {
  final String message;

  SendPinFailedState({
    required this.message,
  });
}
