import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:kavinie/main.dart';
import 'package:kavinie/model/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kavinie/other/home.dart';

class Useradd extends StatefulWidget {
  @override
  State<Useradd> createState() => _UseraddState();
}

class _UseraddState extends State<Useradd> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController Accountnumber;
  late TextEditingController controllerName;
  late TextEditingController controllerLastread;
  late TextEditingController controllerNewread;

  @override
  void initState() {
    super.initState();
    Accountnumber = TextEditingController();
    controllerName = TextEditingController();
    controllerLastread = TextEditingController();
    controllerNewread = TextEditingController();
  }

  @override
  void dispose() {
    Accountnumber.dispose();
    controllerName.dispose();
    controllerLastread.dispose();
    controllerNewread.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Add User'),
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
          const SizedBox(height: 32),
          ElevatedButton(
            child: Text('CreateBill'),
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              if (isValid) {
                final user = User(
                  AccountNumber: Accountnumber.text,
                  CustomerName: controllerName.text,
                  LastRead: controllerLastread.text,
                  NewRead: controllerNewread.text,


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
    final docUser = FirebaseFirestore.instance.collection('report').doc(Accountnumber.text);
    //user.id = docUser.id;

    final json = user.toJson();
    await docUser.set(json);
  }
}