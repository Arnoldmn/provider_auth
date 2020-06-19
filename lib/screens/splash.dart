import 'package:flutter/material.dart';
import 'package:providerauth/helpers/style.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}