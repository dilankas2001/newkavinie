import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'report.dart';

class editnote extends StatefulWidget {
  DocumentSnapshot docid;
  editnote({required this.docid});

  @override
  _editnoteState createState() => _editnoteState(docid: docid);
}

class _editnoteState extends State<editnote> {
  DocumentSnapshot docid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String displayUnit= 'no signal';
  late StreamSubscription _esp32;
  final databse = FirebaseDatabase.instance.ref();
  final FirebaseAuth auth = FirebaseAuth.instance;



  _editnoteState({required this.docid});
  TextEditingController AccountNumber = TextEditingController();
  TextEditingController CustomerName = TextEditingController();
  TextEditingController LastRead = TextEditingController();
  TextEditingController Newread = TextEditingController();
  TextEditingController Unit = TextEditingController();

  void _activateListeners() async {
    _esp32 = databse.child("Py1/User").onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final Object? Units = data['Units'];

      setState(() {
        displayUnit = ' $Units';

      });
    });
  }

  @override
  void initState() {
    AccountNumber = TextEditingController(text: widget.docid.get('AccountNumber'));
    CustomerName = TextEditingController(text: widget.docid.get('CustomerName'));
    LastRead = TextEditingController(text: widget.docid.get('LastRead'));
    Newread = TextEditingController(text: widget.docid.get('Newread'));
    Unit=TextEditingController(text: displayUnit );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final dataRef = databse.child('Py1/User');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 11, 133),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Home()));
            },
            child: Text(
              "Back",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'AccountNumber': AccountNumber.text,
                'CustomerName': CustomerName.text,
                'LastRead': LastRead.text,
                'NewRead': Newread.text
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
              });
            },
            child: Text(
              "save",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
              });
            },
            child: Text(
              "delete",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 199,
                    height: 185,
                    child: Image(image: AssetImage('assets/images/img.png')),
                  ),
                ],
              ),

              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller:  Unit,
                  decoration: InputDecoration(
                    hintText: 'AccountNumber',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: CustomerName,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'CustomerName',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: LastRead,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'LastRead',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: Newread,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'NewRead',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Color.fromARGB(255, 0, 11, 133),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => reportt(
                        docid: docid,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Make Report",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 251, 251, 251),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
