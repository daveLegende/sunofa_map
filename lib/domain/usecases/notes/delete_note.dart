import 'package:dartz/dartz.dart';
import 'package:sunofa_map/core/usecases/usecase.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/domain/repositories/notes/notes_repository.dart';
import 'package:sunofa_map/service_locator.dart';

class DeleteNoteUseCase implements UseCase<Either, IdParms> {

  @override
  Future<Either> call({IdParms? params}) async {
    return sl<NotesRepository>().deleteNote(params!);
  }

}
