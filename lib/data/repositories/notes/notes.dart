import 'package:dartz/dartz.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/data/models/notes/notes.dto.dart';
import 'package:sunofa_map/data/sources/notes/notes.service.dart';
import 'package:sunofa_map/domain/repositories/notes/notes_repository.dart';
import 'package:sunofa_map/service_locator.dart';

class NoteRepositoryImpl extends NotesRepository {
  @override
  Future<Either> getNotes() async {
    return await sl<NoteService>().getNotes();
  }

  @override
  Future<Either> createNote(NoteDTO data) async {
    return await sl<NoteService>().createNote(data);
  }

  @override
  Future<Either> getNote(IdParms data) {
    // TODO: implement getNote
    throw UnimplementedError();
  }

  @override
  Future<Either> updateNote(NoteDTO data) async {
    return await sl<NoteService>().updateNote(data);
  }
  
  @override
  Future<Either> deleteNote(IdParms data) async {
    return await sl<NoteService>().deleteNote(data);
  }
}
