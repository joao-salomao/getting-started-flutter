import 'package:flutter/material.dart';
import 'package:getting_started/pages/cars/car_form_page.dart';
import 'package:getting_started/utils/navigation.dart';
import 'package:getting_started/utils/prefs.dart';
import 'package:getting_started/pages/cars/cars_page.dart';
import 'package:getting_started/widgets/app_drawer_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    print("dentro do initState");
    _initTabs();
  }

  _initTabs() async {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = await Prefs.getInt("TAB_INDEX");
    print('dentro do _initTabs');
    _tabController.addListener(() {
      print("SELECTED TAB: ${_tabController.index}");
      Prefs.setInt("TAB_INDEX", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: "Clássicos",
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              text: "Esportivos",
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              text: "Luxo",
              icon: Icon(Icons.directions_car),
            )
          ],
        ),
      ),
      drawer: DrawerList(),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CarsPage("classicos"),
          CarsPage("esportivos"),
          CarsPage("luxo"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onClickAdd,
      ),
    );
  }

  void _onClickAdd() {
    push(context, CarFormPage());
  }
}
