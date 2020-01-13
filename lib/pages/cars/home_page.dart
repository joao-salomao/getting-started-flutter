import 'package:flutter/material.dart';
import 'package:getting_started/pages/cars/cars_list_view.dart';
import 'package:getting_started/widgets/app_drawer_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Clássicos"),
              Tab(text: "Esportivos"),
              Tab(text: "Luxo")
            ],
          ),
        ),
        drawer: DrawerList(),
        body: TabBarView(
          children: <Widget>[
            CarsListView("classicos"),
            CarsListView("esportivos"),
            CarsListView("luxo"),
          ],
        ),
      ),
    );
  }
}
