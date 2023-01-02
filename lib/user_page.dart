import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:kavinie/main.dart';
import 'package:kavinie/model/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kavinie/other/home.dart';

class UserPage extends StatefulWidget {
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController Accountnumber;
  late TextEditingController controllerName;
  late TextEditingController Address;
  late TextEditingController ContactNo;
  late TextEditingController email;
  late TextEditingController controllerLastread;
  late TextEditingController controllerNewread;
  late TextEditingController Year;
  late TextEditingController Month;

  @override
  void initState() {
    super.initState();
    Accountnumber = TextEditingController();
    controllerName = TextEditingController();
    controllerLastread = TextEditingController();
    controllerNewread = TextEditingController();
    Address =TextEditingController();
    ContactNo = TextEditingController();
    email = TextEditingController();
    Year = TextEditingController();
    Month = TextEditingController();
  }

  @override
  void dispose() {
    Accountnumber.dispose();
    controllerName.dispose();
    controllerLastread.dispose();
    controllerNewread.dispose();
    Address.dispose();
    ContactNo.dispose();
    email.dispose();
    Year.dispose();
    Month.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Add User'),
          backgroundColor: Colors.red,
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: <Widget>[
              TextFormField(
                controller: Accountnumber,
                decoration: decoration('Account Number'),
                validator: (text) =>
                text != null && text.isEmpty ? 'Not valid input' : null,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: controllerName,
                decoration: decoration('Name'),
                validator: (text) =>
                    text != null && text.isEmpty ? 'Not valid input' : null,
              ),
              const SizedBox(height: 24),

              TextFormField(
                controller: Address,
                decoration: decoration('Address'),
                validator: (text) =>
                text != null && text.isEmpty ? 'Not valid input' : null,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: ContactNo,
                decoration: decoration('Contact No'),
                validator: (text) =>
                text != null && text.isEmpty ? 'Not valid input' : null,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: email,
                decoration: decoration('email'),
                validator: (text) =>
                text != null && text.isEmpty ? 'Not valid input' : null,
              ),
              const SizedBox(height: 24),


              const SizedBox(height: 32),
  ElevatedButton(

  child: Text('Create'),
  onPressed: () {
  final isValid = formKey.currentState!.validate();
  if (isValid) {
  final user = User(
  AccountNumber: Accountnumber.text,
  CustomerName: controllerName.text,
    LastRead: controllerLastread.text,
    NewRead: controllerNewread.text,
    Address: Address.text,
    ContactNo: ContactNo.text,
    email: email.text,
    Year: Year.text,
    Month: Month.text


  );
                    createUser(user);

                    final snackBar = SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        'Added ${Accountnumber.text} to Firebase!',
                        style: TextStyle(fontSize: 24),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) =>Home()
    ),
  );
                  }
                },
              ),
            ],
          ),
        ),
      );
  InputDecoration decoration(String label) => InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      );

  Future createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('Bill').doc(Accountnumber.text);
    //user.id = docUser.id;

    final json = user.toJson();
    await docUser.set(json);
  }
}
