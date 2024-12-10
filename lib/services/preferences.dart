import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';

import 'config.dart';

class PreferenceServices {
  static const String userString = 'user';
  // set token
  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(MyConfig().token, token);

    // if (success) {
    //   // print("Token enregistré avec succès");
    // } else {
    //   // print("Erreur lors de l'enregistrement du token");
    // }
  }

  // get token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? success = prefs.getString(MyConfig().token);

    if (success != null) {
      // print("Token réccupéré avec succès $success");
      return success;
    } else {
      // print("Erreur lors de la récupération du token");
      return null;
    }
  }

  // supprimer token
  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(MyConfig().token);
  }

  // ---------------user-----------------
  // get current user
  UserEntity userFromJson(String jsonString) {
    var data = json.decode(jsonString);
    return UserEntity.fromJson(data);
  }

  // save user in shared preferences
  Future<void> saveUserInPreferences(UserEntity user) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    String decodeOptions = jsonEncode(user.toJson());
    sharedUser.setString(userString, decodeOptions);
  }

  // get user in shared preferences
  Future<UserEntity> getUserFromPreference() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    var user = userFromJson(sharedUser.getString(userString)!);
    return user;
  }

  Future<void> removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(userString);
  }
}
