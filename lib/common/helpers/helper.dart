import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sunofa_map/common/api/api.dart';
import 'package:sunofa_map/core/utils/constant.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class Helpers {
  // get color
  Color rubrikolor(int i) {
    switch (i) {
      case 0:
        return AppTheme.primaryColor;
      case 1:
        return AppTheme.primaryColor;
      case 2:
        return AppTheme.primaryColor;
      case 3:
        return AppTheme.primaryColor;
      default:
        return AppTheme.lightGray;
    }
  }

  String getBetName(int i) {
    switch (i) {
      case 0:
        return "Victoire";
      case 1:
        return "Les Deux Equipes Marquent";
      case 2:
        return "Carton Jaune";
      case 3:
        return "Carton Rouge";
      default:
        return "";
    }
  }

  // format
  String formatMontant(double montant) {
    var somme =
        NumberFormat.currency(locale: 'fr-fr', decimalDigits: 0, name: 'cfa')
            .format(montant)
            .toString();
    return somme.trim();
  }

  // score
  String getScore({required int home, required int away}) {
    return "$home : $away";
  }

  String formatNumber(int number) {
    if (number >= 1000) {
      final double abbreviated = number / 1000.0;
      const String suffix = 'k';
      return '${abbreviated.toStringAsFixed(1)}$suffix';
    } else {
      return number.toString();
    }
  }

  String afficherHeureMinute(DateTime dateTime) {
    String heureMinute = DateFormat.Hm().format(dateTime);
    return heureMinute;
  }

  String formatDate(DateTime dateTime) {
    final dt = DateFormat('dd.MM.yy HH:mm').format(dateTime);
    return dt;
  }

  String formatDate2(DateTime dateTime) {
    final dt = DateFormat('dd/MM/yy').format(dateTime);
    return dt;
  }

  String dateEcole(DateTime dateTime) {
    String formattedDate =
        DateFormat('EEEE dd MMMM yyyy', 'fr_FR').format(dateTime);
    return formattedDate[0].toUpperCase() + formattedDate.substring(1);
  }

  String birthDate(DateTime dateTime) {
    String formattedDate =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(dateTime);
    return formattedDate;
  }

  /// Fonction pour modifier l'URL en fonction de l'environnement
  String getCorrectedImageUrl(String url) {
    if (kIsWeb) {
      // Si c'est une application web, on peut utiliser l'URL telle quelle
      return url;
    } else if (Platform.isAndroid || Platform.isIOS) {
      // Si c'est Android ou iOS
      // Vérifier si on est sur un émulateur Android
      if (Platform.isAndroid && !_isPhysicalDevice()) {
        return url.replaceFirst("127.0.0.1", "10.0.2.2");
      } else {
        // Sur un appareil physique, remplacer par l'adresse IP locale du serveur
        return url.replaceFirst(
          "127.0.0.1",
          APIURL.localhost,
        ); // Remplacez par votre IP locale
      }
    } else {
      // Par défaut, si c'est un autre environnement (ex: desktop)
      return url;
    }
  }

  /// Vérifie si l'appareil est physique ou non
  bool _isPhysicalDevice() {
    // Pour l'exemple, on pourrait implémenter une fonction de vérification pour l'émulateur
    // Vous pouvez améliorer cette vérification avec d'autres méthodes si nécessaire
    return !Platform.environment.containsKey('ANDROID_EMULATOR');
  }

  // // has pass
  // Future<String> hashPassword(String password) async {
  //   final hashedPassword =
  //       await BCrypt.hashpw(password, BCrypt.gensalt(logRounds: 10));

  //   return hashedPassword;
  // }

  // snackbar
  void toast({
    required String message,
    Color color = AppTheme.primaryColor,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 3,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  mySnackbar({
    required BuildContext context,
    required String message,
    Color color = AppTheme.primaryColor,
  }) {
    var snackbar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: mwhite),
      ),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
