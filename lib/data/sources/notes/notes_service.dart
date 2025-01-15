// import 'dart:convert';

import 'dart:convert';

import 'package:dartz/dartz.dart';

import 'package:http/http.dart' as http;
import 'package:sunofa_map/common/api/api.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/data/models/notes/notes.dto.dart';
import 'package:sunofa_map/domain/entities/notes/notes.entity.dart';
import 'package:sunofa_map/services/preferences.dart';

abstract class NoteService {
  Future<Either> getNotes();
  Future<Either> getNote(IdParms data);
  Future<Either> createNote(NoteDTO data);
  Future<Either> updateNote(NoteDTO data);
  Future<Either> deleteNote(IdParms data);
}

// implement

class NoteServiceImpl extends NoteService {
  @override
  Future<Either> getNotes() async {
    try {
      final token = await PreferenceServices().getToken();
      final user = await PreferenceServices().getUserFromPreference();
      final response = await http.get(
        Uri.parse(APIURL.notes),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
      );
      String message = "";
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("************************${response.body}");
        List<NoteEntity> myNotes = noteListJson(response.body);
        final notes = myNotes
            .where(
              (element) => element.user.id == user.id,
            )
            .toList();
        return Right(notes);
      } else {
        message = "Une erreur s'est produite";
        print("message ${response.statusCode}");
        return Left(message);
      }
    } catch (e) {
      print("error $e");
      return const Left("Problème lié à la connexion, veuillez réessayer");
    }
  }

  @override
  Future<Either> createNote(NoteDTO data) async {
    try {
      final token = await PreferenceServices().getToken();
      final response = await http.post(
        Uri.parse(APIURL.notes),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(data.toJson()),
      );
      String message = "";
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 302) {
        // final Map<String, dynamic> data = json.decode(response.body);
        print(response.body);
        // CouponEntity coupon = CouponEntity.fromJson(data);
        return const Right("Note ajoutée avec succès");
      } else if (response.statusCode == 404) {
        message = "Une erreur s''est produite";
        print(response.body);
        return Left(message);
      } else {
        message = "Erreur du serveur";
        print(response.body);
        return Left(message);
      }
    } catch (e) {
      print("--------------------$e");
      return const Left("Impossible de créer une note, veuillez réessayer");
    }
  }

  @override
  Future<Either> deleteNote(IdParms data) async {
    try {
      final token = await PreferenceServices().getToken();
      // final user = await PreferenceServices().getUserFromPreference();
      final response = await http.delete(
        Uri.parse("${APIURL.notes}/${data.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(data.toJson()),
      );
      String message = "";
      print("message ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(true);
      } else {
        message = "Une erreur est survenue";
        print("message ${response.statusCode}");
        return Left(message);
      }
    } catch (e) {
      // print("error $e");
      return const Left("Suppression impossible, veuillez réessayer");
    }
  }

  @override
  Future<Either> getNote(IdParms data) {
    // TODO: implement getNote
    throw UnimplementedError();
  }

  @override
  Future<Either> updateNote(NoteDTO data) async {
    try {
      final token = await PreferenceServices().getToken();
      final response = await http.put(
        Uri.parse("${APIURL.notes}/${data.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(data.toJsonWithId()),
      );
      String message = "";
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 302) {
        return const Right("Note modifiée avec succès");
      } else if (response.statusCode == 404) {
        message = "Une erreur s''est produite";
        print(response.body);
        return Left(message);
      } else {
        message = "Erreur du serveur";
        print(response.body);
        return Left(message);
      }
    } catch (e) {
      print("--------------------$e");
      return const Left("Impossible de modifer la note, veuillez réessayer");
    }
  }
}
