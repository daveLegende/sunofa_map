abstract class CreateBookState {}


class CreateBookLoadingState extends CreateBookState {}

class CreateBookSuccessState extends CreateBookState {
  final String message;

  CreateBookSuccessState({
    required this.message,
  });
}

class CreateBookFailedState extends CreateBookState {
  final String message;

  CreateBookFailedState({
    required this.message,
  });
}
