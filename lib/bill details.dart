import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:kavinie/model/user.dart';
import 'package:kavinie/user_page.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'model/user.dart';

class Bill extends StatefulWidget {
  @override
  _BillState createState() => _BillState();
}

class _BillState extends State<Bill> {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late TextEditingController id;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  void initState() {
    super.initState();
    id = TextEditingController();

  }

  void dispose() {
    id.dispose();


    super.dispose();
  }
  Widget buildUsers() => StreamBuilder<List<User>>(
      stream: readUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if (snapshot.hasData) {
          final users = snapshot.data!;

          return ListView(
            children: users.map(buildUser).toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      });

  Widget buildSingleUser() =>  FutureBuilder<DocumentSnapshot>(
    future: users.doc('001').get(),
    builder:
        (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

      if (snapshot.hasError) {
        return Text("Something went wrong");
      }

      if (snapshot.hasData && !snapshot.data!.exists) {
        return Text("Document does not exist");
      }

      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        return Text("Full Name: ${data['name']} ${data['age']}");
      }

      return Text("loading");
    },
  );

  Widget buildUser(User user) => ListTile(
    leading: CircleAvatar(child: Text('${user.age}')),
    title: Text(user.name),
    subtitle: Text(user.birthday.toIso8601String()),
  );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((id) => User.fromJson(id.data())).toList());

  Future<User?> readUser() async {
    /// Get single document by ID
    final docUser = FirebaseFirestore.instance.collection('users').doc(controller.text);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('All Users'),
    ),
    body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
          TextFormField(
          controller: id,
          //decoration: decoration('id'),
          validator: (text) =>
          text != null && text.isEmpty ? 'Not valid input' : null,
        ),
            ElevatedButton(
                child: Text(
                    "Details".toUpperCase(),
                    style: TextStyle(fontSize: 14)
                ),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.pink)
                        )
                    )
                ),
                onPressed: () async {

                  //dataRef
                  //  .set({
                  // "Previous": _Previouscontroller,
                  // "Name":_Namecontroller,

                  //});
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>Bill()),
                  );

                }
            )

      ],
    ),
  )


  );




}
