import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  late final String AccountNumber;
  final String CustomerName;
  final String LastRead;
  final String NewRead;

  User({
    required this.AccountNumber ,
    required this.CustomerName,
    required this.LastRead,
    required this.NewRead,
  });

  Map<String, dynamic> toJson() => {
    'AccountNumber': AccountNumber,
    'CustomerName': CustomerName,
    'LastRead': LastRead,
    'NewRead': NewRead,
  };

  static User fromJson(Map<String, dynamic> json) => User(
    AccountNumber: json['AccountNumber'],
    CustomerName: json['CustomerName'],
    LastRead: json['LastRead'],
    NewRead: json['NewRead'],
  );
}





