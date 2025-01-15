import 'package:sunofa_map/data/models/notes/notes.dto.dart';
import 'package:sunofa_map/domain/usecases/notes/create_note.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_note_state.dart';

class CreateNoteCubit extends Cubit<CreateNoteState> {
  CreateNoteCubit() : super(CreateNoteLoadingState());

  Future<void> createNote(NoteDTO data) async {
    var note = await sl<CreateNoteUseCase>().call(params: data);

    note.fold(
      (l) => emit(CreateNoteFailedState(message: l)),
      (r) => emit(CreateNoteSuccessState(message: r)),
    );
  }
}
