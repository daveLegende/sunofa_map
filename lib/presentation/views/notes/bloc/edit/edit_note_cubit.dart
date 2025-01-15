import 'package:sunofa_map/data/models/notes/notes.dto.dart';
import 'package:sunofa_map/domain/usecases/notes/edit_note.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_note_state.dart';

class EditNoteCubit extends Cubit<EditNoteState> {
  EditNoteCubit() : super(EditNoteLoadingState());

  Future<void> editNote(NoteDTO data) async {
    var notes = await sl<EditNoteUseCase>().call(params: data);

    notes.fold(
      (l) => emit(EditNoteFailedState(message: l)),
      (r) => emit(EditNoteSuccessState(message: r)),
    );
  }
}
