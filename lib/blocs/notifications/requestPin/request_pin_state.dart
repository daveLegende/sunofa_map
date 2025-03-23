import 'package:sunofa_map/domain/entities/notifications/notification.dart';

abstract class RequestPinState {}


class RequestPinLoadingState extends RequestPinState {}

class RequestPinSuccessState extends RequestPinState {
  // final String message;
  final NotificationEntity notification;

  RequestPinSuccessState({
    // required this.message,
    required this.notification,
  });
}

class RequestPinFailedState extends RequestPinState {
  final String message;

  RequestPinFailedState({
    required this.message,
  });
}
