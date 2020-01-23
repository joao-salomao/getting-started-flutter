import 'package:flutter/material.dart';
import 'package:getting_started/entities/user.dart';
import 'package:getting_started/pages/cars/db-helper.dart';
import 'package:getting_started/pages/login_page.dart';
import 'package:getting_started/utils/navigation.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future delayFuture = Future.delayed(Duration(seconds: 3));
    Future dbFuture = DatabaseHelper.getInstance().db; 
    Future<User> userFuture = User.get();

    Future.wait([delayFuture, dbFuture, userFuture]).then((List results) {
      User user = results[2];
    if (user != null) {
      push(context, HomePage(), replace: true);
    } else {
      push(context, LoginPage(), replace: true);
    }
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}