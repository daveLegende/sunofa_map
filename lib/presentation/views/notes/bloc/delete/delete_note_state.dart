abstract class DeleteNoteState {}


class DeleteNoteLoadingState extends DeleteNoteState {}

class DeleteNoteSuccessState extends DeleteNoteState {
  final bool message;

  DeleteNoteSuccessState({
    required this.message,
  });
}

class DeleteNoteFailedState extends DeleteNoteState {
  final String message;

  DeleteNoteFailedState({
    required this.message,
  });
}
