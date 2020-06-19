import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerauth/helpers/style.dart';
import 'package:providerauth/providers/auth.dart';
import 'package:providerauth/screens/home.dart';
import 'package:providerauth/screens/login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider.initialize(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AfriMarket",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: ScreenController(),
    );
  }
}

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    if (auth.status == Status.Uninitialized) {
      return SplashScreen();
    } else {
      if (auth.loggedIn) {
        return HomePage();
      } else {
        return LoginPage();
      }
    }
  }
}

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
