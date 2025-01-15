import 'package:sunofa_map/domain/entities/user/user_entity.dart';

abstract class UserState {}


class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {
  final UserEntity user;

  UserSuccessState({
    required this.user,
  });
}

class UserFailedState extends UserState {
  final String message;

  UserFailedState({
    required this.message,
  });
}
