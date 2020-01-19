import 'dart:async';
import 'package:getting_started/entities/car.dart';
import 'package:getting_started/utils/api.dart';

class CarsBloc {
  final StreamController _streamController = StreamController<List<Car>>();
  Stream get stream => _streamController.stream;

  loadCars(String carsType) async {
    try {
    List<Car> cars = await Api.getCars(carsType);
    _streamController.add(cars);

    } catch(error) {
      _streamController.addError(error);
    }
  }

  void dispose() {
    _streamController.close();
  }
}