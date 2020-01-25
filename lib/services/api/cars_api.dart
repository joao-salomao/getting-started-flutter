import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:getting_started/entities/car.dart';
import 'package:getting_started/services/api/api.dart';

class CarsApi {
  static Future<ApiResponse<Car>> create(Car car) async {
    try {
      final String url =
          "https://carros-springboot.herokuapp.com/api/v2/carros";
      Map<String, String> headers = await Api.getHeaders();
      String json = car.toJson();

      final response = await http.post(url, headers: headers, body: json);

      Map mapResponse = convert.json.decode(response.body);
      if (response.statusCode == 201) {
        Car car = Car.fromMap(mapResponse);
        print("Novo carro: ${car.id}");
        return ApiResponse.sucess(car);
      } else {
        ApiResponse.error(mapResponse['error']);
      }
    } catch (error) {
      return ApiResponse.error(
          "Não foi possível salvar o carro. Tente novamente");
    }
  }

  static Future<ApiResponse<Car>> update(Car car) async {
    try {
      final String url = "https://carros-springboot.herokuapp.com/api/v2/carros/${car.id}";
      Map<String, String> headers = await Api.getHeaders();
      String json = car.toJson();

      final response = await http.put(url, headers: headers, body: json);

      Map mapResponse = convert.json.decode(response.body);
      if (response.statusCode == 200) {
        Car car = Car.fromMap(mapResponse);
        print("Carro Atualizado com sucesso");
        return ApiResponse.sucess(car);
      } else {
        ApiResponse.error(mapResponse['error']);
      }
    } catch (error) {
      return ApiResponse.error(
          "Não foi possível salvar o carro. Tente novamente");
    }
  }
}
