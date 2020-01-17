import 'dart:async';
import 'package:getting_started/entities/car.dart';
import 'package:getting_started/utils/api.dart';

class CarsBloc {
  final StreamController _streamController = StreamController<List<Car>>();
  Stream get stream => _streamController.stream;

  loadCars(String carsType) async {
    List<Car> cars = await Api.getCars(carsType);
    _streamController.add(cars);
  }

  void dispose() {
    _streamController.close();
  }
}