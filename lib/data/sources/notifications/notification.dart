import 'dart:convert';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sunofa_map/common/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';
import 'package:sunofa_map/domain/entities/notifications/notification.dart';
import 'package:sunofa_map/services/preferences.dart';

import 'package:dartz/dartz.dart';

import 'package:sunofa_map/data/models/id.dto.dart';

abstract class NotificationService {
  Future<Either> sendPin(IdParms data);
  Future<Either> requestPin(IdParms data);
  Future<Either> validatePin(FullPin data);
}

// implement

class NotificationServiceImpl extends NotificationService {
  @override
  Future<Either> requestPin(IdParms data) async {
    try {
      final token = await PreferenceServices().getToken();
      final response = await http.post(
        Uri.parse("${APIURL.adresses}/${data.id}/request-pin"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token",
        },
      );
      String message = "";
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        message = data['message'];
        final notif = NotificationEntity.fromJson(data);
        // CouponEntity coupon = CouponEntity.fromJson(data);
        return Right(notif);
      } else {
        final Map<String, dynamic> data = json.decode(response.body);
        message = data['message'];
        return Left(message);
      }
    } catch (e) {
      print("--------------------$e");
      return const Left("Demande impossible, veuillez réessayer");
    }
  }

  @override
  Future<Either> sendPin(IdParms data) async {
    try {
      final token = await PreferenceServices().getToken();
      final response = await http.post(
        Uri.parse("${APIURL.adresses}/${data.id}/send-code-pin"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token",
        },
      );
      String message = "";
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        message = data['message'];
        final ad = AdressesEntity.fromJson2(data['data']);
        // CouponEntity coupon = CouponEntity.fromJson(data);
        return Right(ad);
      } else {
        final Map<String, dynamic> data = json.decode(response.body);
        message = data['error'];
        return Left(message);
      }
    } catch (e) {
      print("--------------------$e");
      return const Left("Envoie de pin échouée, veuillez réessayer");
    }
  }

  @override
  Future<Either> validatePin(FullPin data) async {
    try {
      final token = await PreferenceServices().getToken();
      final response = await http.post(
        Uri.parse("${APIURL.adresses}/${data.id}/validate-pin"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(data.toJson()),
      );
      String message = "";
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        message = data['message'];
        // CouponEntity coupon = CouponEntity.fromJson(data);
        return Right(message);
      } else {
        final Map<String, dynamic> data = json.decode(response.body);
        message = data['message'];
        return Left(message);
      }
    } catch (e) {
      print("--------------------$e");
      return const Left("Validation de pin impossible, veuillez réessayer");
    }
  }
}

class NotifImpl {
  Future<void> notifyAllUsers({
    required String title,
    String? subtitle,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${APIURL.notifications}/all"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "title": title,
          "subtitle": subtitle ?? "",
          "body": body,
          "data": data ?? {},
        }),
      );
      print("************************${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("************************${response.body}");
        print("************************Notification envoyée");
      } else {
        print("message ${response.body}");
        // return Left(message);
      }
    } catch (e) {
      print("error $e");
      // return const Left("Problème lié à la connexion, veuillez réessayer");
    }
  }

  Future<void> notifyGroup({
    required String group,
    required String title,
    String? subtitle,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      final url = Uri.parse("${APIURL.notifications}/group");
      final response = await http.post(
        Uri.parse("${APIURL.notifications}/all"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "group": group,
          "title": title,
          "subtitle": subtitle ?? "",
          "body": body,
          "data": data ?? {},
        }),
      );

      if (response.statusCode == 200) {
        print("Notification envoyée au groupe $group !");
      } else {
        print("Échec de l'envoi : ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Erreur lors de l'envoi de la notification : $e");
    }
  }

  Future<void> notifyUser({
    required String userId,
    required String title,
    String? subtitle,
    required String body,
    List<String>? data,
  }) async {
    try {
      // final user = await PreferenceServices().getUserFromPreference();
      await OneSignal.login(userId);
      print("Données envoyées: ${jsonEncode({
            "userId": userId,
            "title": title,
            "subtitle": subtitle ?? "",
            "body": body,
            "data": data ?? [],
          })}");
      final response = await http.post(
        Uri.parse("https://sunofamap.com/api/v1/notify/user"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "userId": userId,
          "title": title,
          "subtitle": subtitle ?? "",
          "body": body,
          if (data != null && data.isNotEmpty) "data": data,
        }),
      );

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
