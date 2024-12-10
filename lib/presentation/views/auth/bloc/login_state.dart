abstract class LoginState {}


class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailedState extends LoginState {
  final String message;

  LoginFailedState({
    required this.message,
  });
}
