import 'dart:convert';

import 'package:onesignal_flutter/onesignal_flutter.dart';
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

  Future<void> saveNotificationPermission() async {
    // Récupérer la permission des notifications
    bool hasPermission = await OneSignal.Notifications.permission;

    // Sauvegarder la valeur dans SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification_permission', hasPermission);

    print("Permission des notifications sauvegardée : $hasPermission");
  }

  Future<bool?> getNotificationPermission() async {
    // Récupérer la valeur depuis SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? hasPermission = prefs.getBool('notification_permission');

    print("Permission des notifications récupérée : $hasPermission");
    return hasPermission;
  }

  Future<void> saveNotification(OSNotification notification) async {
    final prefs = await SharedPreferences.getInstance();

    // Récupérer la liste actuelle des notifications
    final List<String> notificationsJson =
        prefs.getStringList('notifications') ?? [];

    // Convertir la notification en JSON
    final notificationJson = {
      'title': notification.title,
      'body': notification.body,
      'subtitle': notification.subtitle,
      // 'timestamp': DateTime.now().toIso8601String(),
    };

    // Ajouter la nouvelle notification à la liste
    notificationsJson!.add(json.encode(notificationJson));

    // Sauvegarder la liste mise à jour
    await prefs.setStringList('notifications', notificationsJson);
  }

  Future<List<Map<String, dynamic>>> getSavedNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> notificationsJson =
        prefs.getStringList('notifications') ?? [];

    // Convertir les JSON en objets Map
    return notificationsJson
        .map((jsonString) => json.decode(jsonString) as Map<String, dynamic>)
        .toList();
  }
}
