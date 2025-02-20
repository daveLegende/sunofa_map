import 'package:sunofa_map/common/api/api.dart';
import 'package:sunofa_map/services/preferences.dart';
import 'package:http/http.dart' as http;

class FilePermission {
  static Future<String> getPermissionToImages() async {
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
      String message = "";
      print("************************${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Success";
      } else {
        message = "Une erreur s'est produite";
        print("message ${response.body}");
        return message;
      }
    } catch (e) {
      print("error $e");
      return "error $e";
    }
  }
  static Future<String> getPermissionToVideos() async {
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
      String message = "";
      print("************************${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Success";
      } else {
        message = "Une erreur s'est produite";
        print("message ${response.body}");
        return message;
      }
    } catch (e) {
      print("error $e");
      return "error $e";
    }
  }
  static Future<String> getPermissionToAudios() async {
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
      String message = "";
      print("************************${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Success";
      } else {
        message = "Une erreur s'est produite";
        print("message ${response.body}");
        return message;
      }
    } catch (e) {
      print("error $e");
      return "error $e";
    }
  }
}
