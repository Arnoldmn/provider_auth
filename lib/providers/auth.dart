import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:providerauth/helpers/screen_navigation.dart';
import 'package:providerauth/helpers/user.dart';
import 'package:providerauth/models/user.dart';
import 'package:providerauth/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  static const LOGGED_IN = 'loggedIn';
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  Status _status = Status.Unauthenticated;
  UserServices _userServices = UserServices();
  UserModel _userModel;
  TextEditingController phoneNumber;

  String smsOTP;
  String verificationId;
  String errorMessage = '';
  bool loggedIn = false;
  bool loading = false;

  UserModel get userModel => _userModel;

  Status get status => _status;

  FirebaseUser get user => _user;

  AuthProvider.initialize() {
    readPrefs();
  }

  Future<void> readPrefs() async {
    await Future.delayed(Duration(seconds: 3)).then(
      (v) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        loggedIn = prefs.getBool(LOGGED_IN) ?? false;

        if (loggedIn) {
          _user = await _auth.currentUser();
          _userModel = await _userServices.getUserById(_user.uid);
          _status = Status.Authenticated;
          notifyListeners();
          return;
        }
        _status = Status.Unauthenticated;
        notifyListeners();
      },
    );
    handleError(error, BuildContext context) {
      print(error);
      errorMessage = error.toString();
      notifyListeners();
      switch (error.code) {
        case 'ERROR_INVALID_VERIFICATION_CODE':
          print('The verification code is invalid');
          break;
        default:
          errorMessage = error.message;
          break;
      }
      notifyListeners();
    }

    Future<void> verifyPhone(BuildContext context, String number) async {
      final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
        this.verificationId = verId;
        smsOTPDialog(context).then((value) {
          print('Sign in');
        });
      };
      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: number.trim(),
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential.toString() + "Welcome to our app");
          },
          verificationFailed: (AuthException exception) {
            print('${exception.message}+something is wrong');
          },
          codeSent: smsOTPSent,
          codeAutoRetrievalTimeout: (String verId) {
            this.verificationId = verId;
          },
        );
      } catch (e, context) {
        errorMessage = e.toString();
        notifyListeners();
      }
    }
  }

  void _createUser({String id, String number}) {
    _userServices.createUser(
      {"id": id, "number": number},
    );
  }

  signIn(BuildContext context) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: verificationId, smsCode: smsOTP);
      final AuthResult user = await _auth.signInWithCredential(credential);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.user.uid == currentUser.uid);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(LOGGED_IN, false);
      loggedIn = true;
      if (user != null) {
        _userModel = await _userServices.getUserById(user.user.uid);
        if (_userModel == null) {
          _createUser(id: user.user.uid, number: user.user.phoneNumber);
        }
        loading = false;
        Navigator.of(context).pop();
        changeScreenReplacement(
          context,
          HomePage(),
        );
      }
      loading = false;
      Navigator.of(context).pop();
      changeScreenReplacement(
        context,
        HomePage(),
      );
    } catch (e) {
      print("${e.toString()}");
    }
  }

  Future<bool> smsOTPDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter sms code'),
          content: Container(
            height: 85.0,
            child: Column(
              children: <Widget>[
                TextField(
                  onChanged: (value) {
                    this.smsOTP = value;
                  },
                )
              ],
            ),
          ),
          contentPadding: EdgeInsets.all(10.0),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                loading = true;
                notifyListeners();
                _auth.currentUser().then(
                  (user) async {
                    if (user != null) {
                      _userModel = await _userServices.getUserById(user.uid);
                      if (user != null) {
                        _userModel = await _userServices.getUserById(user.uid);
                        if (_userModel == null) {
                          _createUser(id: user.uid, number: user.phoneNumber);

                          Navigator.of(context).pop();
                          loading = false;
                          notifyListeners();
                          changeScreenReplacement(
                            context,
                            HomePage(),
                          );
                        } else {
                          loading = true;
                          notifyListeners();
                          Navigator.of(context).pop();
                          loading = false;
                          signIn(context);
                        }
                      }
                    }
                  },
                );
              },
              child: Text("Done"),
            )
          ],
        );
      },
    );
  }
}
