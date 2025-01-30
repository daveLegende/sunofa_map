abstract class UpdateUserState {}


class UpdateUserLoadingState extends UpdateUserState {}

class UpdateUserSuccessState extends UpdateUserState {
  final String message;

  UpdateUserSuccessState({
    required this.message,
  });
}

class UpdateUserFailedState extends UpdateUserState {
  final String message;

  UpdateUserFailedState({
    required this.message,
  });
}
