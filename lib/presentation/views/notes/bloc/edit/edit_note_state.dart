abstract class EditNoteState {}


class EditNoteLoadingState extends EditNoteState {}

class EditNoteSuccessState extends EditNoteState {
  final String message;

  EditNoteSuccessState({
    required this.message,
  });
}

class EditNoteFailedState extends EditNoteState {
  final String message;

  EditNoteFailedState({
    required this.message,
  });
}
