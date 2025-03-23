import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:sunofa_map/common/api/api.dart';
import 'package:sunofa_map/core/utils/constant.dart';
import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';
import 'package:sunofa_map/themes/app_themes.dart';
import 'package:nyx_converter/nyx_converter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
      gravity: ToastGravity.BOTTOM,
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

  //
  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) return "Ajouté le $d";
    if (diff.inDays > 30) {
      return "Ajouté il y'a ${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "mois" : "mois"}";
    }
    if (diff.inDays > 7) {
      return "Ajouté il y'a ${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "sem" : "sem"}";
    }
    if (diff.inDays > 0) {
      return "Ajouté il y'a ${diff.inDays} ${diff.inDays == 1 ? "jour" : "jours"}";
    }
    if (diff.inHours > 0) {
      return "Ajouté il y'a ${diff.inHours} ${diff.inHours == 1 ? "heure" : "heures"}";
    }
    if (diff.inMinutes > 0) {
      return "Ajouté il y'a ${diff.inMinutes} ${diff.inMinutes == 1 ? "min" : "min"}";
    }
    return "Ajouté à l'instant";
  }

  String formatAudioDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = duration.inMinutes.toString();
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  String removeEmojis(String text) {
    return text.replaceAll(RegExp(r'[\u{1F600}-\u{1F64F}]', unicode: true), '');
  }

  ImageProvider getImageProvider(String imagePath) {
    if (imagePath.startsWith('http')) {
      return NetworkImage(imagePath);
    } else {
      return FileImage(File(imagePath));
    }
  }

  Future<String?> convertM4AToMP3(String inputFilePath) async {
    try {
      // Obtenir le répertoire de stockage temporaire
      Directory tempDir = await getTemporaryDirectory();
      String outputFilePath = '${tempDir.path}/converted_audio.mp3';

      // Effectuer la conversion
      await NyxConverter.convertTo(
        inputFilePath,
        outputFilePath,
        container: NyxContainer.mp3,
      );

      print("Conversion terminée : $outputFilePath");
      return outputFilePath;
    } catch (e) {
      print("Erreur lors de la conversion : $e");
      return null;
    }
  }

  // Future<void> openGoogleMaps(
  //     {AdressesEntity? adresse}) async {
  //   Uri googleMapsUrl;

  //   if (adresse!.latitude != null && adresse.longitude != null) {
  //     // Si latitude et longitude sont disponibles
  //     googleMapsUrl = Uri.parse(
  //         "https://www.google.com/maps/search/?api=1&query=${adresse.latitude},${adresse.longitude}");
  //   } else if (adresse.googleAddress != null && adresse.googleAddress!.isNotEmpty) {
  //     // Si l'adresse est disponible, mais pas les coordonnées
  //     final String encodedAddress = Uri.encodeComponent(adresse.googleAddress!);
  //     googleMapsUrl = Uri.parse(
  //         "https://www.google.com/maps/search/?api=1&query=$encodedAddress");
  //   } else {
  //     throw 'Aucune donnée valide pour ouvrir Google Maps';
  //   }

  //   if (await canLaunchUrl(googleMapsUrl)) {
  //     await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
  //   } else {
  //     throw 'Impossible d\'ouvrir Google Maps';
  //   }
  // }

  // Future<void> openGoogleMaps({required AdressesEntity adresse}) async {
  //   // Récupérer la position actuelle de l'utilisateur
  //   Position currentPosition = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );

  //   Uri googleMapsUrl;

  //   // Si latitude et longitude de l'adresse sont disponibles
  //   if (adresse.latitude != null && adresse.longitude != null) {
  //     googleMapsUrl = Uri.parse(
  //         "google.navigation:q=${adresse.latitude},${adresse.longitude}&origin=${currentPosition.latitude},${currentPosition.longitude}");
  //   }
  //   // Si une adresse sous forme de texte est fournie
  //   else if (adresse.googleAddress != null &&
  //       adresse.googleAddress!.isNotEmpty) {
  //     final String encodedAddress = Uri.encodeComponent(adresse.googleAddress!);
  //     googleMapsUrl = Uri.parse(
  //         "google.navigation:q=$encodedAddress&origin=${currentPosition.latitude},${currentPosition.longitude}");
  //   } else {
  //     throw 'Aucune donnée valide pour ouvrir Google Maps';
  //   }

  //   // Vérifier si l'URL peut être lancée
  //   if (await canLaunchUrl(googleMapsUrl)) {
  //     await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
  //   } else {
  //     throw 'Impossible d\'ouvrir Google Maps';
  //   }
  // }

  Future<void> openGoogleMaps({required AdressesEntity adresse}) async {
    // Vérifier et demander la permission de localisation
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Permission de localisation refusée';
      }
    }

    // Si la permission est définitivement refusée, demander à l'utilisateur d'aller dans les paramètres
    if (permission == LocationPermission.deniedForever) {
      throw 'La permission de localisation est refusée en permanence. Veuillez l\'activer dans les paramètres.';
    }

    // Récupérer la position actuelle de l'utilisateur
    Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    Uri googleMapsUrl;

    // Si latitude et longitude de l'adresse sont disponibles
    if (adresse.latitude != null && adresse.longitude != null) {
      googleMapsUrl = Uri.parse(
          "google.navigation:q=${adresse.latitude},${adresse.longitude}&origin=${currentPosition.latitude},${currentPosition.longitude}");
    }
    // Si une adresse sous forme de texte est fournie
    else if (adresse.googleAddress != null &&
        adresse.googleAddress!.isNotEmpty) {
      final String encodedAddress = Uri.encodeComponent(adresse.googleAddress!);
      googleMapsUrl = Uri.parse(
          "google.navigation:q=$encodedAddress&origin=${currentPosition.latitude},${currentPosition.longitude}");
    } else {
      throw 'Aucune donnée valide pour ouvrir Google Maps';
    }

    // Vérifier si l'URL peut être lancée
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Impossible d\'ouvrir Google Maps';
    }
  }
}
