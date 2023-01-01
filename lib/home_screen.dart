import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kavinie/login_screen.dart';
import 'package:kavinie/other/home.dart';
import 'package:kavinie/user_page.dart';
import 'add.dart';

import 'package:controller/controller.dart';
import 'package:flutter_text_form_field/flutter_text_form_field.dart';

class HomePage extends HookConsumerWidget {
  // const HomePage({Key? key}) : super(key: key)

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeExtend(),
    );
  }
}

class HomeExtend extends StatefulWidget {
  @override
  State<HomeExtend> createState() => _HomeExtendState();
}

class _HomeExtendState extends State<HomeExtend> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController id;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String displayUnit = 'no signal';
  String displayPrevious = 'no signal';
  String displayName = 'no signal';
  late StreamSubscription _esp32;
  //const HomeExtend({Key? key}) : super(key: key);
  final databse = FirebaseDatabase.instance.ref();
  final TextEditingController _Namecontroller = TextEditingController();
  final TextEditingController _Previouscontroller = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void initState() {
    // super.initState();
    _activateListeners();
    id = TextEditingController();
  }

  void dispose() {
    id.dispose();

    super.dispose();
  }

  void _activateListeners() async {
    _esp32 = databse.child("Py1/User").onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final Object? Units = data['Units'];
      final Object? Previous = data['Previous'];
      final Object? Name = data['Name'];

      setState(() {
        displayUnit = ' $Units';
        displayPrevious = '$Previous';
        displayName = '$Name';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('users').snapshots();
    final dataRef = databse.child('Py/Users');
    return Scaffold(
      appBar: AppBar(
        title: Text("EBMS"),
        backgroundColor: Color.fromARGB(255, 233, 54, 30),
        actions: <Widget>[
          //IconButton
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'loout Icon',
            onPressed: () {
              signOut();
              //signout function
            },
          ), //IconButton
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
      body: StreamBuilder(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("something is wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 199,
                      height: 185,
                      child: Image(image: AssetImage('assets/images/img.png')),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                      color: Color(0xffd9d9d9),
                      //padding: const EdgeInsets.only(left: 131, right: 152, top: 21, bottom: 15, ),
                    ),
                    SizedBox(height: 36),
                    ElevatedButton(
                        child: Text("Calculate Bill".toUpperCase(),
                            style: TextStyle(fontSize: 14)),
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(500, 40)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 16, 11, 11)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 249, 225, 10)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(color: Colors.pink)))),
                        onPressed: () async {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => Home()));
                        }),
                    SizedBox(height: 36),
                    ElevatedButton(
                        child: Text("Register New Customer".toUpperCase(),
                            style: TextStyle(fontSize: 14)),
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(500, 40)),
                            overlayColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 254, 248, 247)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 21, 20, 11)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 249, 225, 10)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(
                                        color:
                                            Color.fromARGB(255, 245, 22, 22))))),
                        onPressed: () async {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => UserPage()));
                        }),
                  ]),
            );
          }),
    );
  }
}
