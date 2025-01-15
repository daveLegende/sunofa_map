
import 'package:sunofa_map/domain/entities/notes/notes.entity.dart';

abstract class NoteState {}


class NoteLoadingState extends NoteState {}

class NoteSuccessState extends NoteState {
  final List<NoteEntity> notes;

  NoteSuccessState({
    required this.notes,
  });
}

class NoteFailedState extends NoteState {
  final String message;

  NoteFailedState({
    required this.message,
  });
}
