import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String label;
  Function onPressed;

  AppButton(this.label, { this.onPressed });

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