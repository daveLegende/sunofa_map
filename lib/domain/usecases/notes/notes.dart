import 'package:dartz/dartz.dart';
import 'package:sunofa_map/core/usecases/usecase.dart';
import 'package:sunofa_map/data/models/notes/notes.dto.dart';
import 'package:sunofa_map/domain/repositories/notes/notes_repository.dart';
import 'package:sunofa_map/service_locator.dart';

class NoteUseCase implements UseCase<Either, NoteDTO> {

  @override
  Future<Either> call({NoteDTO? params}) async {
    return sl<NotesRepository>().getNotes();
  }

}
