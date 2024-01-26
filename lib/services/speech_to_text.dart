// import "dart:convert";
//
// import "package:http/http.dart" as http;
// import "package:meme/model/memes_response.dart";
//
// abstract class API {
//   static const String _baseUrl = 'https://api.imgflip.com';
//   static Future<MemeData> getMeme() async {
//     final response = await http.get(Uri.parse('$_baseUrl/get_memes'));
//     print('API Response Status Code: ${response.statusCode}');
//     print('API Response Body: ${response.body}');
//     if (response.statusCode == 200) {
//       final MemeResponse memesResponse =
//       MemeResponse.fromJson(jsonDecode(response.body));
//       return memesResponse.data!;
//     } else {
//       throw Exception('Failed to load memes');
//     }
//   }
// }