import 'package:flutter/material.dart';

class AppRaisedButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  AppRaisedButton(this.label, { this.onPressed });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      color: Colors.blue,
      onPressed: onPressed,
    );
  }
}