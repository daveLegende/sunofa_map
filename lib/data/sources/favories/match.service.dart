// import 'package:dartz/dartz.dart';
// import 'package:tournoi_zemoz/common/api/api.dart';

// import 'package:http/http.dart' as http;
// import 'package:tournoi_zemoz/features/domain/entities/match/match.entity.dart';

// abstract class MatchService {
//   Future<Either> getMatchs();
// }

// class MatchServiceImpl extends MatchService {
//   @override
//   Future<Either> getMatchs() async {
//     try {
//       final response = await http.get(
//         Uri.parse(APIURL.matchsURL),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//         },
//       );
//       String message = "";
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // print("************************${response.body}");
//         List<MatchEntity> infos = matchListFromJson(response.body);
//         return Right(infos);
//       } else {
//         message = "Une erreur s'est produite";
//         // print("message ${response.statusCode}");
//         return Left(message);
//       }
//     } catch (e) {
//       print("error $e");
//       return const Left("Problème lié à la connexion, veuillez réessayer");
//     }
//   }
// }
