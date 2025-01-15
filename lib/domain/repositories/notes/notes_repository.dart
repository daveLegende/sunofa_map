import 'package:dartz/dartz.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/data/models/notes/notes.dto.dart';

abstract class NotesRepository {
  Future<Either> getNotes();
  Future<Either> getNote(IdParms data);
  Future<Either> createNote(NoteDTO data);
  Future<Either> updateNote(NoteDTO data);
  Future<Either> deleteNote(IdParms data);
}