import 'package:flutter/material.dart';
import 'package:getting_started/entities/car.dart';
import 'package:getting_started/pages/cars/cars_list_view.dart';
import 'package:getting_started/utils/api.dart';
import 'package:getting_started/widgets/app_drawer_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      drawer: DrawerList(),
      body: _body(),
    );
  }

  _body() {
    Future<List<Car>> future = Api.getCars();
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Car> cars = snapshot.data;
        return CarsListView(cars);
      },
    );
  }
}
