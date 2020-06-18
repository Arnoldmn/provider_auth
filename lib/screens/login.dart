import 'package:flutter/material.dart';
import 'package:providerauth/helpers/style.dart';
import 'package:providerauth/widgets/custom_button.dart';
import 'package:providerauth/widgets/custom_text.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/applogo.png',
                  width: 100.0,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            CustomText(
              text: "AfriMarket",
              size: 28,
              weight: FontWeight.bold,
            ),
            SizedBox(
              height: 5.0,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: "Welcome to the ", style: TextStyle(color: Colors.blue.shade900),),
                  TextSpan(
                    text: "AfriMarket",
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  TextSpan(text: " App", style: TextStyle(color: Colors.blue.shade900)),
                ],
                style: TextStyle(color: black),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: black, width: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: grey.withOpacity(0.3),
                        offset: Offset(2, 1),
                        blurRadius: 2)
                  ],
                ),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: phoneNumber,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.phone_android,
                      color: grey,

                    ),
                    border: InputBorder.none,
                    hintText: "+254 700 890 980",
                    hintStyle: TextStyle(
                      color: grey,
                      fontFamily: "Sen",
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "After entering your phone number, click on verify to authenticate yourself! Then wait up to 20 seconds to get th OTP and procede",
                textAlign: TextAlign.center,
                style: TextStyle(color: grey),
              ),
            ),
            SizedBox(height: 10),
            CustomButton(
              msg: "Verify",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
