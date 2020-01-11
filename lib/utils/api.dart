import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:getting_started/entities/user.dart';

class Api {
  static final headers = {"Content-Type": "application/json"};

  static Future<User> auth(String username, String password) async {
    final String url = "https://carros-springboot.herokuapp.com/api/v2/login";

    Map map = {
      "username": username,
      "password": password,
    };

    String mapEncoded = convert.jsonEncode(map);

    var response = await http.post(
      url,
      headers: headers,
      body: mapEncoded,
    );

    if (response.statusCode == 200) {
      Map jsonResponse = convert.jsonDecode(response.body);
      return User.fromJson(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}
