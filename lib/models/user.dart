import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NUMBER = "number";
  static const ID = "id";

  String _phoneNumber;
  String _id;

  String get number => _phoneNumber;

  String get id => _id;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _phoneNumber = snapshot.data[NUMBER];
    _id = snapshot.data[ID];
  }
}
