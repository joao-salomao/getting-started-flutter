import 'package:flutter/material.dart';

class AppRaisedButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final bool isLoading;

  AppRaisedButton(this.label, {this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
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