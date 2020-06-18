import 'package:flutter/material.dart';
import 'package:providerauth/helpers/style.dart';
import 'package:providerauth/widgets/custom_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          title: CustomText(
            text: "AfriMarket",
          ),
          centerTitle: true,
          elevation: 0.5,
        ),
        backgroundColor: white,
        body: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () {},
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
