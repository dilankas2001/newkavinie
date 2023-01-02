import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'bill.dart';

class editnote extends StatefulWidget {
  DocumentSnapshot docid;
  editnote({required this.docid});

  @override
  _editnoteState createState() => _editnoteState(docid: docid);
}

class _editnoteState extends State<editnote> {
  DocumentSnapshot docid;
  CollectionReference users = FirebaseFirestore.instance.collection('Bill');
  String displayUnit= 'no signal';
  String displayPrevious = 'no signal';
  String displayName = 'no signal';
  late StreamSubscription _esp32;
  final databse = FirebaseDatabase.instance.ref();
  final FirebaseAuth auth = FirebaseAuth.instance;



  _editnoteState({required this.docid});
  TextEditingController AccountNumber = TextEditingController();
  TextEditingController CustomerName = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController ContactNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController LastRead = TextEditingController();
  TextEditingController NewRead = TextEditingController();
  TextEditingController Unit = TextEditingController();
  TextEditingController Year = TextEditingController();
  TextEditingController Month = TextEditingController();





  void _activateListeners() async {
    _esp32 = databse.child("Py1/User").onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final Object? Units = data['Units'];
      final Object? Total = data['Total'];
      final Object? Usage = data['Usage'];
      final Object? Previous = data['Previous'];
      final Object? Name = data['Name'];

      setState(() {
        displayUnit = ' $Units';
        displayPrevious = '$Previous';
        displayName='$Name';
      });
    });
  }

  @override
  void initState() {
    _activateListeners();
    AccountNumber = TextEditingController(text: widget.docid.get('AccountNumber'));
    CustomerName = TextEditingController(text: widget.docid.get('CustomerName'));
    Address = TextEditingController(text: widget.docid.get('Address'));
    ContactNo = TextEditingController(text: widget.docid.get('ContactNo'));
    email = TextEditingController(text: widget.docid.get('email'));
    LastRead = TextEditingController(text: widget.docid.get('LastRead'));
    NewRead = TextEditingController(text: widget.docid.get('NewRead'));
    Year =TextEditingController(text: widget.docid.get('Year'));
    Month = TextEditingController(text: widget.docid.get('Month'));



    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> _usersStream =
    FirebaseFirestore.instance.collection('Bill').snapshots();
    final dataRef = databse.child('Py/Users');
    return Scaffold(
      appBar: AppBar(title:Text("EBMS"),
        backgroundColor:Colors.pink,
        actions: <Widget>[

          //IconButton
          IconButton(
            icon: const Icon(Icons.undo),
            tooltip: 'Back',
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Home()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'delete',
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
              });
            },
          ), //Ico
          //IconButton
        ], //<Widget>[]

        elevation: 50.0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menu Icon',
          onPressed: () async {
            // Navigator.push(context,
            // MaterialPageRoute(builder: (context) => TestHome()));

          },
        ),
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
                   // child: Image(image: AssetImage('assets/images/img.png')),
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
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                color: Color(0xffd9d9d9),
                //padding: const EdgeInsets.only(left: 131, right: 152, top: 21, bottom: 15, ),
                child: Row(
                  //mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Text(
                      "New Read: " + displayUnit,
                      style: TextStyle(
                        letterSpacing: 1.0,
                        // default is 0.0
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: AccountNumber,
                decoration: decoration('Account Number'),
                validator: (text) =>
                text != null && text.isEmpty ? 'Not valid input' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: CustomerName,
                decoration: decoration('Customer Name'),
                validator: (text) =>
                text != null && text.isEmpty ? 'Not valid input' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: Address,
                decoration: decoration('Address'),
                validator: (text) =>
                text != null && text.isEmpty ? 'Not valid input' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 10,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: ContactNo,
                decoration: decoration('Contact No'),
                validator: (text) =>
                text != null && text.isEmpty ? 'Not valid input' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 10,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: email,
                decoration: decoration('email'),
                validator: (text) =>
                text != null && text.isEmpty ? 'Not valid input' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 10,
              ),

              TextFormField(
                controller: Year,
                decoration: decoration('Year'),
                validator: (text) =>
                text != null && text.isEmpty ? 'Not valid input' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 10,
              ),

              TextFormField(
                controller: Month,
                decoration: decoration('Month'),
                validator: (text) =>
                text != null && text.isEmpty ? 'Not valid input' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 10,
              ),

              const SizedBox(height: 24),
              TextFormField(
                controller: LastRead,
                decoration: decoration('Last read'),
                validator: (text) =>
                text != null && text.isEmpty ? 'Not valid input' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Color.fromARGB(255, 238, 37, 119),
                onPressed: () {

                  widget.docid.reference.update({
                    'CustomerName': CustomerName.text,
                    'Address':Address.text,
                    'ContactNo':ContactNo.text,
                    'email' : email.text,
                    'Year': Year.text,
                    'Month':Month.text,
                    'LastRead': LastRead.text,
                    'NewRead': displayUnit,
                    'Total': displayUnit,
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GenaratedBill(
                        docid: docid,
                      ),
                    ),
                  );

                },
                child: Text(
                  "Create Bill",
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

  InputDecoration decoration(String label) => InputDecoration(
    labelText: label,
    border: OutlineInputBorder(),
  );
}
