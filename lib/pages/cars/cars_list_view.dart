import 'package:flutter/material.dart';
import 'package:getting_started/entities/car.dart';

class CarsListView extends StatelessWidget {
  final List<Car> cars;

  CarsListView(this.cars);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _listView(cars),
    );
  }

  Container _listView(List<Car> cars) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          Car car = cars[index];
          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.network(
                      car.urlFoto,
                      width: 300,
                    ),
                  ),
                  _text(car.nome, fontSize: 25),
                  _text("DESCRIÇÃO....", fontSize: 16),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: _text("Detalhes"),
                        onPressed: () {/* ... */},
                      ),
                      FlatButton(
                        child: _text("Compartilhar"),
                        onPressed: () {/* ... */},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Text _text(String text, {double fontSize = 19}) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize),
    );
  }
}
