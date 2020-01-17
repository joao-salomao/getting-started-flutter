import 'package:flutter/material.dart';
import 'package:getting_started/entities/car.dart';
import 'package:getting_started/pages/cars/cars_bloc.dart';
import 'package:getting_started/widgets/app_loader.dart';

class CarsListView extends StatefulWidget {
  final String carsType;

  CarsListView(this.carsType);

  @override
  _CarsListViewState createState() => _CarsListViewState();
}

class _CarsListViewState extends State<CarsListView>
    with AutomaticKeepAliveClientMixin<CarsListView> {
  @override
  bool get wantKeepAlive => true;
  String get carsType => widget.carsType;

  CarsBloc _bloc = CarsBloc();

  @override
  void initState() {
    super.initState();
    _bloc.loadCars(carsType);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _errorApi();
        }
        if (!snapshot.hasData) {
          return AppLoader();
        }
        List<Car> cars = snapshot.data;
        return _listView(cars);
      },
    );
  }

  Center _errorApi() {
    return Center(
          child: Text(
            "Não foi possível carregar os carros",
            style: TextStyle(
              fontSize: 25,
              color: Colors.red,
            ),
          ),
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
                  Image.network(
                    car.urlFoto,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
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
      style: TextStyle(
        fontSize: fontSize,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
