import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:getting_started/entities/car.dart';
import 'package:getting_started/entities/user.dart';

class Api {
  static final headers = {"Content-Type": "application/json"};

  static Future<ApiResponse> auth(String username, String password) async {
    try {
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
        return ApiResponse.sucess(User.fromJson(jsonResponse));
      } else {
        return ApiResponse.error("O usuário ou a senha estão incorretos");
      }
    } catch (error, exception) {
      print("Erro no login\n Error: $error\n Exception: $exception");
      return ApiResponse.error("Não foi possível fazer o login");
    }
  }

  static Future<List<Car>> getCars(String type) async {
    try {
      final url = "http://carros-springboot.herokuapp.com/api/v1/carros/tipo/$type";
      final response = await http.get(url);
      final json = response.body;
      final List mapList = convert.jsonDecode(json);
      final List<Car> cars =
          mapList.map<Car>((map) => Car.fromJson(map)).toList();

      return cars;
    } catch (error) {
      return [];
    }
  }
}

class ApiResponse<T> {
  bool ok;
  String message;
  T result;

  ApiResponse.sucess(this.result) {
    ok = true;
  }

  ApiResponse.error(this.message) {
    ok = false;
  }
}
