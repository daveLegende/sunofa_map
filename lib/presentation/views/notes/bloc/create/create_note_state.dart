abstract class CreateNoteState {}


class CreateNoteLoadingState extends CreateNoteState {}

class CreateNoteSuccessState extends CreateNoteState {
  final String message;

  CreateNoteSuccessState({
    required this.message,
  });
}

class CreateNoteFailedState extends CreateNoteState {
  final String message;

  CreateNoteFailedState({
    required this.message,
  });
}
