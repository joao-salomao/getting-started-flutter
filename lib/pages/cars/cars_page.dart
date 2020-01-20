import 'package:flutter/material.dart';
import 'package:getting_started/entities/car.dart';
import 'package:getting_started/pages/cars/cars_bloc.dart';
import 'package:getting_started/pages/cars/cars_list_view.dart';
import 'package:getting_started/widgets/app_loader.dart';

class CarsPage extends StatefulWidget {
  final String carsType;

  CarsPage(this.carsType);

  @override
  _CarsListViewState createState() => _CarsListViewState();
}

class _CarsListViewState extends State<CarsPage>
    with AutomaticKeepAliveClientMixin<CarsPage> {
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
        return RefreshIndicator(
          child: CarsListView(cars),
          onRefresh: _onRefresh,
        );
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

  Future<List<Car>> _onRefresh() {
    return _bloc.loadCars(carsType);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.closeStream();
  }
}
