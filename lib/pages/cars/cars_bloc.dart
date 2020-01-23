import 'package:getting_started/dao/car_dao.dart';
import 'package:getting_started/utils/api.dart';
import 'package:getting_started/entities/car.dart';
import 'package:getting_started/utils/network.dart';
import 'package:getting_started/utils/simple_bloc.dart';

class CarsBloc extends SimpleBloc<List<Car>> {
  Future<List<Car>> loadCars(String carsType) async {
    List<Car> cars = [];
    try {
      bool networkOn = await isNetworkOn();
      
      if (!networkOn) {
        List<Car> cars = await CarDAO().findAllByType(carsType);
        add(cars);
        return cars;
      }

      cars = await Api.getCars(carsType);

      if (cars.isNotEmpty) {
        final dao = CarDAO();
        cars.forEach(dao.save);
      }  

      add(cars);
    } catch (error) {
      addError(error);
    }
    return cars;
  }
}
