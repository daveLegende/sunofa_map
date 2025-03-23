
// import 'package:http/http.dart' as http;
// import 'package:sunofa_map/common/api/api.dart';
// import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';
// import 'package:sunofa_map/services/preferences.dart';

// class FavorisRepository {
//   static Future<AdressesEntity> updateAdresse({required bool isFavorited, required String adresseId}) async {
//     try {
//       final token = await PreferenceServices().getToken();
//       var request = http.MultipartRequest(
//         'POST', // Utilisez POST pour simuler PUT avec _method=PUT
//         Uri.parse("${APIURL.adresses}/$adresseId"),
//       );

//       // Ajouter les en-têtes
//       request.headers.addAll({
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       });

//       // Ajouter le champ _method=PUT pour simuler une requête PUT
//       request.fields['_method'] = 'PUT';

//       // Ajouter les champs de données
//       request.fields['user_id'] = data.user_id.toString();
//       request.fields['pseudo'] = data.pseudo.trim();
//       request.fields['adressName'] = data.adressName.trim();
//       request.fields['city'] = data.city.trim();
//       request.fields['info'] = data.info!.trim();

//       if (data.googleAddress != null) {
//         request.fields['googleAddress'] = data.googleAddress!;
//       }
//       if (data.longitude != null) {
//         request.fields['longitude'] = data.longitude.toString();
//       }
//       if (data.latitude != null) {
//         request.fields['latitude'] = data.latitude.toString();
//       }
//       if (data.codePin != null) {
//         request.fields['codePin'] = data.codePin.toString();
//       }

//       // Fonction pour ajouter des fichiers s'ils existent
//       Future<void> addFileIfExists(String? path, String fieldName,
//           {List<String>? validExtensions}) async {
//         if (path != null && path.isNotEmpty && File(path).existsSync()) {
//           if (validExtensions != null &&
//               !validExtensions.contains(path.split('.').last.toLowerCase())) {
//             print("❌ Format invalide pour $fieldName : $path");
//             return;
//           }
//           request.files.add(await http.MultipartFile.fromPath(fieldName, path));
//           print("✅ Fichier ajouté pour $fieldName : $path");
//         } else {
//           print("⚠️ Fichier introuvable ou chemin vide pour $fieldName: $path");
//         }
//       }

//       // Ajouter les fichiers multimédias
//       await addFileIfExists(data.media!.photo1, 'photo1');
//       await addFileIfExists(data.media!.photo2, 'photo2');
//       await addFileIfExists(data.media!.video1, 'video1');
//       await addFileIfExists(data.media!.video2, 'video2');

//       if (data.media!.audio1 != null &&
//           File(data.media!.audio1!).existsSync()) {
//         request.files.add(
//             await http.MultipartFile.fromPath('audio1', data.media!.audio1!));
//         print("✅ Audio ajouté : ${data.media!.audio1}");
//       } else {
//         print("⚠️ Aucun fichier audio à ajouter.");
//       }

//       // Envoyer la requête
//       final response = await request.send();
//       final responseData = await response.stream.bytesToString();
//       print("Response: $responseData");

//       // Gérer la réponse
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return Right("Adresse modifiée avec succès");
//       } else if (response.statusCode == 404) {
//         return Left("Une erreur s'est produite");
//       } else {
//         return Left("Erreur du serveur");
//       }
//     } catch (e) {
//       print("--------------------$e");
//       return const Left("Impossible de modifier l'adresse, veuillez réessayer");
//     }
//   }
// }