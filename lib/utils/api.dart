import 'dart:convert' as convert;
import 'package:getting_started/entities/car.dart';
import 'package:http/http.dart' as http;
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

  static List<Car> getCars() {
    List<Car> cars = List<Car>();

    cars.add(Car(nome: "Camaro", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Camaro_SS.png"));
    cars.add(Car(nome: "Camaro SS 1969", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Camaro_SS.png"));
    cars.add(Car(nome: "Dodge Challenger", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Dodge_Challenger.png"));
    cars.add(Car(nome: "Ford Mustang 1976", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Ford_Mustang.png"));

    return cars;
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
