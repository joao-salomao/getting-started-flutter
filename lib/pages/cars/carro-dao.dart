import 'dart:async';
import 'package:getting_started/entities/car.dart';
import 'package:getting_started/pages/cars/db-helper.dart';
import 'package:sqflite/sqflite.dart';

// Data Access Object
class CarroDAO {

  Future<Database> get db => DatabaseHelper.getInstance().db;

  Future<int> save(Car carro) async {
    var dbClient = await db;
    var id = await dbClient.insert("cars", carro.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('id: $id');
    return id;
  }

  Future<List<Car>> findAll() async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from cars');

    final carros = list.map<Car>((json) => Car.fromJson(json)).toList();

    return carros;
  }

  Future<List<Car>> findAllByTipo(String tipo) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from cars where tipo =? ',[tipo]);

    final carros = list.map<Car>((json) => Car.fromJson(json)).toList();

    return carros;
  }

  Future<Car> findById(int id) async {
    var dbClient = await db;
    final list =
        await dbClient.rawQuery('select * from cars where id = ?', [id]);

    if (list.length > 0) {
      return new Car.fromJson(list.first);
    }

    return null;
  }

  Future<bool> exists(Car carro) async {
    Car c = await findById(carro.id);
    var exists = c != null;
    return exists;
  }

  Future<int> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select count(*) from cars');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from cars where id = ?', [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from cars');
  }
}
