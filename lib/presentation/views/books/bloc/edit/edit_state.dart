abstract class EditBookState {}


class EditBookLoadingState extends EditBookState {}

class EditBookSuccessState extends EditBookState {
  final String message;

  EditBookSuccessState({
    required this.message,
  });
}

class EditBookFailedState extends EditBookState {
  final String message;

  EditBookFailedState({
    required this.message,
  });
}
