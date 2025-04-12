import 'dart:convert';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';

class PreferenceServices {
  static const String userString = 'user';
  static const String tokenKey = 'token';
  // set token
  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);

    // if (success) {
    //   // print("Token enregistré avec succès");
    // } else {
    //   // print("Erreur lors de l'enregistrement du token");
    // }
  }

  // get token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? success = prefs.getString(tokenKey);

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
    await prefs.remove(tokenKey);
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

  // Future<void> saveNotification(OSNotification notification) async {
  //   final prefs = await SharedPreferences.getInstance();

  //   // Récupérer la liste actuelle des notifications
  //   final List<String> notificationsJson =
  //       prefs.getStringList('notifications') ?? [];
  //   print("/*//*/*/*/*//*///*/////*/*/");
  //   print("/*//*/*/*/*notification.additionalData${notification.additionalData}//*/////*/*/");
  //   print("/*//*/*/*/*//*///*/////*/*/");

  //   final add = json.decode(notification.additionalData!["address"]) as Map<String, dynamic>;
  //   final user = json.decode(notification.additionalData!["requested_by"]) as Map<String, dynamic>;

  //   // Convertir la notification en JSON
  //   final notificationJson = {
  //     'title': notification.title,
  //     'body': notification.body,
  //     'subtitle': notification.subtitle,
  //     "address": AdressesEntity.fromJson(add),
  //     "requested_by": UserEntity.fromJson(user),
  //     // 'timestamp': DateTime.now().toIso8601String(),
  //   };

  //   // Ajouter la nouvelle notification à la liste
  //   notificationsJson.add(json.encode(notificationJson));
  //   print(
  //       "Notification -------------------------------------------- ${notificationJson.toString()}");

  //   // Sauvegarder la liste mise à jour
  //   await prefs.setStringList('notifications', notificationsJson);
  // }

  Future<void> saveNotification(OSNotification notification) async {
    if (notification.additionalData == null) {
      print("Aucune donnée supplémentaire dans la notification");
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final List<String> notificationsJson =
        prefs.getStringList('notifications') ?? [];

    try {
      // Création d'un ID unique basé sur les données critiques
      final uniqueId = _generateNotificationId(notification);

      // Vérifier si la notification existe déjà
      if (_notificationExists(notificationsJson, uniqueId)) {
        print("Notification déjà existante: $uniqueId");
        return;
      }

      final notificationData = _buildNotificationData(notification);
      notificationsJson.add(json.encode(notificationData));

      await prefs.setStringList('notifications', notificationsJson);
      print("Notification sauvegardée: ${notificationData.toString()}");
    } catch (e, stack) {
      print("Erreur lors de la sauvegarde: $e");
      print(stack);
    }
  }

// Helper methods
  String _generateNotificationId(OSNotification notification) {
    final data = notification.additionalData!;
    return "${data['request_id']}_${DateTime.now().millisecondsSinceEpoch}";
  }

  bool _notificationExists(List<String> notificationsJson, String uniqueId) {
    return notificationsJson.any((n) {
      try {
        final decoded = json.decode(n) as Map;
        return decoded['unique_id'] == uniqueId;
      } catch (_) {
        return false;
      }
    });
  }

  Map<String, dynamic> _buildNotificationData(OSNotification notification) {
    final data = notification.additionalData!;

    return {
      'unique_id': _generateNotificationId(notification),
      'title': notification.title,
      'body': notification.body,
      'subtitle': notification.subtitle,
      'address': _parseDataField(data["address"]),
      'requested_by': _parseDataField(data["requested_by"]),
      'date': DateTime(2025, 04, 13).toIso8601String(),
      'original_data': data, // Conserve les données brutes
    };
  }

  dynamic _parseDataField(dynamic field) {
    if (field is String) {
      try {
        return json.decode(field);
      } catch (_) {
        return field;
      }
    }
    return field;
  }

  Future<List<Map<String, dynamic>>> getSavedNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> notificationsJson =
        prefs.getStringList('notifications') ?? [];

    // Convertir les JSON en objets Map
    final listNotifs = notificationsJson
        .map((jsonString) => json.decode(jsonString) as Map<String, dynamic>)
        .toList();
    print("Get all notifications on local storage");
    print(listNotifs);
    print("End aff Get all notifications on local storage");
    return listNotifs;
  }

  Future<void> clearAllNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('notifications');
  }

  Future<void> deleteNotification(String uniqueId) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final List<String> notificationsJson =
          prefs.getStringList('notifications') ?? [];

      // Filtrer pour garder toutes les notifications SAUF celle à supprimer
      final updatedNotifications = notificationsJson.where((notificationJson) {
        try {
          final notification =
              json.decode(notificationJson) as Map<String, dynamic>;
          return notification['unique_id'] != uniqueId;
        } catch (e) {
          // Si erreur de décodage, on conserve la notification
          return true;
        }
      }).toList();

      await prefs.setStringList('notifications', updatedNotifications);
      print("Notification $uniqueId supprimée avec succès");
    } catch (e, stack) {
      print("Erreur lors de la suppression: $e");
      print(stack);
      throw Exception("Failed to delete notification");
    }
  }
}
