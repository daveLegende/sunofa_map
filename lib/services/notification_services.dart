// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'preferences.dart';

// class NotificationService {
//   static const String baseUrl = "https://sunofamap.com/api/v1/notify";

//   static Future<void> notifyAllUsers({
//     required String title,
//     String? subtitle,
//     required String body,
//     Map<String, dynamic>? data,
//   }) async {
//     final url = Uri.parse("$baseUrl/all");
//     final headers = {
//       "Accept-Language": "en",
//       "Content-Type": "application/json",
//       "Accept": "application/json",
//     };
//     final bodyData = jsonEncode({
//       "title": title,
//       "subtitle": subtitle ?? "",
//       "body": body,
//       "data": data ?? {},
//     });

//     final response = await http.post(url, headers: headers, body: bodyData);

//     if (response.statusCode == 200) {
//       print("Notification envoyée avec succès !");
//     } else {
//       print("Échec de l'envoi : ${response.body}");
//     }
//   }

//   //
//   static Future<void> notifyGroup({
//     required String group,
//     required String title,
//     String? subtitle,
//     required String body,
//     Map<String, dynamic>? data,
//   }) async {
//     final url = Uri.parse("$baseUrl/group");
//     final headers = {
//       "Accept-Language": "en",
//       "Content-Type": "application/json",
//       "Accept": "application/json",
//     };
//     final bodyData = jsonEncode({
//       "group": group,
//       "title": title,
//       "subtitle": subtitle ?? "",
//       "body": body,
//       "data": data ?? {},
//     });

//     final response = await http.post(url, headers: headers, body: bodyData);

//     if (response.statusCode == 200) {
//       print("Notification envoyée au groupe $group !");
//     } else {
//       print("Échec de l'envoi : ${response.body}");
//     }
//   }

//   //
//   static Future<void> notifyUser({
//     required String userId,
//     required String title,
//     String? subtitle,
//     required String body,
//     List<String>? data,
//   }) async {
//     final token = await PreferenceServices().getToken();
//     final user = await PreferenceServices().getUserFromPreference();
//     final url = Uri.parse("$baseUrl/user");
//     final headers = {
//       "Accept-Language": "en",
//       "Content-Type": "application/json",
//       "Accept": "application/json",
//       "Authorization": "Bearer $token",
//     };
//     final bodyData = jsonEncode({
//       "userId": user.id!,
//       "title": title,
//       "subtitle": subtitle ?? "",
//       "body": body,
//       "data": data ?? [],
//     });

//     final response = await http.post(url, headers: headers, body: bodyData);

//     if (response.statusCode == 200) {
//       print("Notification envoyée à l'utilisateur $userId !");
//     } else {
//       print("Échec de l'envoi : ${response.body}");
//     }
//   }
// }



import 'dart:convert';
import 'package:http/http.dart' as http;

import 'preferences.dart';

class NotificationService {
  static const String baseUrl = "https://sunofamap.com/api/v1/notify";

  static Future<void> notifyAllUsers({
    required String title,
    String? subtitle,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/all");
      final headers = {
        "Accept-Language": "en",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      final bodyData = jsonEncode({
        "title": title,
        "subtitle": subtitle ?? "",
        "body": body,
        "data": data ?? {},
      });

      final response = await http.post(url, headers: headers, body: bodyData);

      if (response.statusCode == 200) {
        print("Notification envoyée avec succès !");
      } else {
        print("Échec de l'envoi : ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Erreur lors de l'envoi de la notification : $e");
    }
  }

  static Future<void> notifyGroup({
    required String group,
    required String title,
    String? subtitle,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/group");
      final headers = {
        "Accept-Language": "en",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      final bodyData = jsonEncode({
        "group": group,
        "title": title,
        "subtitle": subtitle ?? "",
        "body": body,
        "data": data ?? {},
      });

      final response = await http.post(url, headers: headers, body: bodyData);

      if (response.statusCode == 200) {
        print("Notification envoyée au groupe $group !");
      } else {
        print("Échec de l'envoi : ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Erreur lors de l'envoi de la notification : $e");
    }
  }

  static Future<void> notifyUser({
    required String userId,
    required String title,
    String? subtitle,
    required String body,
    List<String>? data,
  }) async {
    try {
      // final token = await PreferenceServices().getToken();
      final user = await PreferenceServices().getUserFromPreference();
      final url = Uri.parse("$baseUrl/user");
      final headers = {
        "Accept-Language": "en",
        "Content-Type": "application/json",
        "Accept": "application/json",
        // "Authorization": "Bearer $token",
      };
      final bodyData = jsonEncode({
        "userId": user.id!,
        "title": title,
        "subtitle": subtitle ?? "",
        "body": body,
        "data": data ?? [],
      });

      final response = await http.post(url, headers: headers, body: bodyData);

      if (response.statusCode == 200) {
        print("Notification envoyée à l'utilisateur $userId !");
      } else {
        print("Échec de l'envoi : ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Erreur lors de l'envoi de la notification : $e");
    }
  }
}