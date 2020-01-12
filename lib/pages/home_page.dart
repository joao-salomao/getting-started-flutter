import 'package:flutter/material.dart';
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
    return Container(
      child: Center(
        child: Text("HOME PAGE JOÃO SALOMÃO"),
      ),
    );
  }
}
