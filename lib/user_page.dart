import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:kavinie/main.dart';
import 'package:kavinie/model/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserPage extends StatefulWidget {
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController id;
  late TextEditingController controllerName;
  late TextEditingController controllerAge;
  late TextEditingController controllerDate;

  @override
  void initState() {
    super.initState();
    id = TextEditingController();
    controllerName = TextEditingController();
    controllerAge = TextEditingController();
    controllerDate = TextEditingController();
  }

  @override
  void dispose() {
    id.dispose();
    controllerName.dispose();
    controllerAge.dispose();
    controllerDate.dispose();

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
                controller: id,
                decoration: decoration('id'),
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
                controller: controllerAge,
                decoration: decoration('Age'),
                keyboardType: TextInputType.number,
                validator: (text) => text != null && int.tryParse(text) == null
                    ? 'Not valid input'
                    : null,
              ),
              const SizedBox(height: 24),
              DateTimeField(
                controller: controllerDate,
                decoration: decoration('Birthday'),
                validator: (dateTime) =>
                    dateTime == null ? 'Not valid input' : null,
                format: DateFormat('yyyy-MM-dd'),
                onShowPicker: (context, currentValue) => showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  initialDate: currentValue ?? DateTime.now(),
                ),
              ), const SizedBox(height: 32),
  ElevatedButton(
  child: Text('Create'),
  onPressed: () {
  final isValid = formKey.currentState!.validate();

  if (isValid) {
  final user = User(
  id: id.text,
  name: controllerName.text,
  age: int.parse(controllerAge.text),
  birthday: DateTime.parse(controllerDate.text),
  );


                    createUser(user);

                    final snackBar = SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        'Added ${controllerName.text} to Firebase!',
                        style: TextStyle(fontSize: 24),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    Navigator.pop(context);
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
    final docUser = FirebaseFirestore.instance.collection('users').doc(id.text);
    //user.id = docUser.id;

    final json = user.toJson();
    await docUser.set(json);
  }
}
