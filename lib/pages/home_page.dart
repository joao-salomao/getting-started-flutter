import 'package:flutter/material.dart';
import 'package:getting_started/entities/car.dart';
import 'package:getting_started/utils/api.dart';
import 'package:getting_started/widgets/app_drawer_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Home Page"),
        ),
      ),
      drawer: DrawerList(),
      body: _body(),
    );
  }

  _body() {
    List<Car> cars = Api.getCars();

    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (context, index) {
        Car car = cars[index];
        return Row(
          children: <Widget>[
            Image.network(car.urlFoto, width: 200,),
            Text(car.nome, 
              style: TextStyle(fontSize: 20),
            )
          ],
        );
      },
    );
  }
}
