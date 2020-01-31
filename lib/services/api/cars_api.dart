import 'dart:io';
import 'dart:convert' as convert;
import 'package:getting_started/entities/car.dart';
import 'package:getting_started/services/api/api.dart';
import 'package:getting_started/utils/http_helper.dart' as http;
import 'package:getting_started/services/api/upload_api.dart';

class CarsApi {
  static Future<ApiResponse> create(Car car, File file) async {
    ApiResponse apiResponse;
    try {
      final String url =
          "https://carros-springboot.herokuapp.com/api/v2/carros";
      
      await _uploadCarPhotoHandle(car, file);

      String json = car.toJson();

      final response = await http.post(url, body: json);

      Map mapResponse = convert.json.decode(response.body);
      if (response.statusCode == 201) {
        Car car = Car.fromMap(mapResponse);
        print("Novo carro: ${car.id}");
        apiResponse = ApiResponse.sucess(car);
      } else {
        apiResponse = ApiResponse.error(mapResponse['error']);
      }
    } catch (error) {
      apiResponse = ApiResponse.error(
          "Não foi possível salvar o carro. Tente novamente");
    }
    return apiResponse;
  }

  static Future<ApiResponse> update(Car car, File file) async {
    ApiResponse apiResponse;
    try {
      final String url = "https://carros-springboot.herokuapp.com/api/v2/carros/${car.id}";

      await _uploadCarPhotoHandle(car, file);

      String json = car.toJson();

      final response = await http.put(url, body: json);

      Map mapResponse = convert.json.decode(response.body);
      if (response.statusCode == 200) {
        Car car = Car.fromMap(mapResponse);
        print("Carro Atualizado com sucesso");
        apiResponse = ApiResponse.sucess(car);
      } else {
        apiResponse = ApiResponse.error(mapResponse['error']);
      }
    } catch (error) {
      apiResponse = ApiResponse.error(
          "Não foi possível salvar o carro. Tente novamente");
    }
    return apiResponse;
  }

    static Future<ApiResponse> delete(Car car) async {
    ApiResponse apiResponse;
    try {
      final String url = "https://carros-springboot.herokuapp.com/api/v2/carros/${car.id}";

      final response = await http.delete(url);

      Map mapResponse = convert.json.decode(response.body);
      if (response.statusCode == 200) {
        print("Carro deletado com sucesso");
        apiResponse = ApiResponse.sucess(true);
      } else {
        apiResponse = ApiResponse.error(mapResponse['error']);
      }
    } catch (error) {
      apiResponse = ApiResponse.error(
          "Não foi possível deletar o carro. Tente novamente");
    }
    return apiResponse;
  }

  static Future<void> _uploadCarPhotoHandle(Car car, File file) async {
      if (file != null) {
        final uploadResponse = await UploadApi.upload(file);
        if (uploadResponse.ok) {
          car.urlFoto = uploadResponse.result;
        }
      }
  }
}
