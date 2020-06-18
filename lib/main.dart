import 'package:flutter/material.dart';
import 'package:providerauth/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AfriMarket",
      theme: ThemeData(
        primaryColor: Colors.white,
      ), home: LoginPage(),
    );
  }
}
