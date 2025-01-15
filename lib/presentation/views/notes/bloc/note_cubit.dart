import 'package:sunofa_map/domain/usecases/notes/notes.dart';
import 'package:sunofa_map/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteLoadingState());

  Future<void> getNotes() async {
    var notes = await sl<NoteUseCase>().call();

    notes.fold(
      (l) => emit(NoteFailedState(message: l)),
      (r) => emit(NoteSuccessState(notes: r)),
    );
  }
}
