import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/domain/usecases/notes/delete_note.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delete_note_state.dart';

class DeleteNoteCubit extends Cubit<DeleteNoteState> {
  DeleteNoteCubit() : super(DeleteNoteLoadingState());

  Future<void> deleteNote(IdParms data) async {
    var notes = await sl<DeleteNoteUseCase>().call(params: data);

    notes.fold(
      (l) => emit(DeleteNoteFailedState(message: l)),
      (r) => emit(DeleteNoteSuccessState(message: r)),
    );
  }
}
