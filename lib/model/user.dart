import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  late final String AccountNumber;
  final String CustomerName;
  late final String Address;
  final String ContactNo;
  final String email;
  final String LastRead;
  final String NewRead;
  final String Year;
  late final String Month;

  User({
    required this.Address,
    required this.ContactNo,
    required this.email,
    required this.AccountNumber ,
    required this.CustomerName,
    required this.LastRead,
    required this.NewRead,
    required this.Year,
    required this.Month,


});

  Map<String, dynamic> toJson() => {
    'AccountNumber': AccountNumber,
    'CustomerName': CustomerName,
    'Address':Address,
    'ContactNo':ContactNo,
    'email':email,
    'LastRead': LastRead,
    'NewRead': NewRead,
    'Year': Year,
    'Month': Month,

  };

  static User fromJson(Map<String, dynamic> json) => User(
    AccountNumber: json['AccountNumber'],
    CustomerName: json['CustomerName'],
    Address: json['Address'],
    ContactNo: json['ContactNo'],
    email: json['email'],
    LastRead: json['LastRead'],
    NewRead: json['NewRead'],
    Year: json['Year'],
    Month: json['Month'],
  );
}


class Add {
  late final String AccountNumber;
  final String Year;
  late final String Month;


  Add({

    required this.AccountNumber ,
    required this.Year,
    required this.Month,

  });

  Map<String, dynamic> toJson() => {
    'AccountNumber': AccountNumber,
    'Year': Year,
    'Month': Month,

  };

  static Add fromJson(Map<String, dynamic> json) => Add(
    AccountNumber: json['AccountNumber'],
   Year: json['Year'],
   Month: json['Month'],

  );
}





