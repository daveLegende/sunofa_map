abstract class RegisterState {}


class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterFailedState extends RegisterState {
  final String message;

  RegisterFailedState({
    required this.message,
  });
}
