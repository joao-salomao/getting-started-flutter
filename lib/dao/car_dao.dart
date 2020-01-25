import 'package:getting_started/dao/base_dao.dart';
import 'package:getting_started/entities/car.dart';

class CarDAO extends BaseDAO<Car> {
  @override
  String get table => "cars";

  @override
  Car fromJson(Map<String, dynamic> map) {
    return Car.fromMap(map);
  }

    Future<List<Car>> findAllByType(String type) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from $table where tipo =? ',[type]);

    return list.map<Car>((json) => fromJson(json)).toList();
  }

}
