import 'package:flutter/material.dart';
import 'package:getting_started/entities/car.dart';
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
    List<Car> cars = Api.getCars();

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
                  Text(
                    car.nome,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text("DESCRIÇÃO...."),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text("Detalhes", style: TextStyle(fontSize: 19),),
                        onPressed: () {/* ... */},
                      ),
                      FlatButton(
                        child: Text("Compartilhar", style: TextStyle(fontSize: 19),),
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
}
