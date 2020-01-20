import 'package:getting_started/utils/api.dart';
import 'package:getting_started/entities/car.dart';
import 'package:getting_started/utils/simple_bloc.dart';

class CarsBloc extends SimpleBloc<List<Car>> {
  Future<List<Car>> loadCars(String carsType) async {
    List<Car> cars = [];
    try {
      cars = await Api.getCars(carsType);
      add(cars);
    } catch (error) {
      addError(error);
    }
    return cars;
  }
}
