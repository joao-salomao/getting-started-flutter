import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getting_started/entities/car.dart';
import 'package:getting_started/pages/cars/car_page.dart';
import 'package:getting_started/utils/navigation.dart';

class CarsListView extends StatelessWidget {
  final List<Car> cars;

  CarsListView(this.cars);

  @override
  Widget build(BuildContext context) {
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
                  CachedNetworkImage(
                    imageUrl: car.urlFoto ?? "https://cdn.europosters.eu/image/750/posters/cars-3-mcqueen-race-i47515.jpg",
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error)),
                  ),
                  _text(car.nome, fontSize: 25),
                  _text("DESCRIÇÃO....", fontSize: 16),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: _text("Detalhes"),
                        onPressed: () {
                          push(context, CarPage(car));
                        },
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
      style: TextStyle(
        fontSize: fontSize,
      ),
    );
  }
}
