import 'package:flutter/material.dart';
import 'package:sunofa_map/common/api/api.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/services/preferences.dart';
import 'package:sunofa_map/themes/app_themes.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class VocalAdresse extends StatelessWidget {
  const VocalAdresse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        // vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(
            Icons.play_arrow,
            size: 30,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Slider(
              activeColor: AppTheme.primaryColor,
              inactiveColor: Colors.grey[600],
              value: 0,
              onChanged: (value) {},
              min: 0.0,
              max: 100.0,
            ),
          ),
        ],
      ),
    );
  }
}

// class AdresseImage extends StatelessWidget {
//   const AdresseImage({
//     super.key,
//     required this.image,
//   });
//   final String image;

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: Image(
//         height: 100,
//         fit: BoxFit.cover,
//         image: NetworkImage("${APIURL.localhost}/$image"),
//       ),
//     );
//   }
// }

class AdresseImage extends StatelessWidget {
  const AdresseImage({
    super.key,
    required this.image,
  });

  final String image;

  Future<String> _fetchImageUrl() async {
    try {
      final token = await PreferenceServices().getToken();
      final response = await http.get(
        Uri.parse("${APIURL.localhost}/photos"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        print("${response.body}");
        // Si la réponse est correcte, retourne l'URL de l'image
        return "${APIURL.localhost}";
      } else if (response.statusCode == 404) {
        // Si l'image n'est pas trouvée
        print("${response.body}");
        throw Exception("Image non trouvée (404)");
      } else if (response.statusCode == 403) {
        // Si l'accès est interdit
        throw Exception("Accès interdit (403)");
      } else {
        // Autres erreurs
        throw Exception("Erreur ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      // En cas d'erreur
      throw Exception(
          "Une erreur s'est produite lors de la récupération de l'image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _fetchImageUrl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingCircle();
        } else if (snapshot.hasError) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 100,
              color: mred.withOpacity(.3),
              child: const Center(
                child: Text("Image non trouvée"),
              ),
            ),
          );
        } else if (snapshot.hasData) {
          // Image récupérée avec succès, affichage de l'image
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              snapshot.data!,
              height: 100,
              fit: BoxFit.cover,
            ),
          );
        } else {
          return const Center(
            child: Text('Aucune image disponible'),
          );
        }
      },
    );
  }
}
