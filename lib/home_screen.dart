import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kavinie/bill%20details.dart';
import 'package:kavinie/login_screen.dart';
import 'package:kavinie/other/home.dart';
import 'package:kavinie/test.dart';
import 'package:kavinie/user_page.dart';
import 'add.dart';
import 'bill.dart';
import 'datapage.dart';
import 'package:controller/controller.dart';
import 'package:flutter_text_form_field/flutter_text_form_field.dart';

import 'edit.dart';



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
  String displayUnit= 'no signal';
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
        displayName='$Name';
       
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
    FirebaseFirestore.instance.collection('users').snapshots();
    final dataRef = databse.child('Py/Users');
    return
      Scaffold(

      appBar: AppBar(title:Text("EBMS"),
          backgroundColor:Colors.pink,
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


      body:StreamBuilder(
    stream: _usersStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text("something is wrong");
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 199,
              height: 185,
              child: Image(image: AssetImage('assets/images/img.png')),
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
                    "Customer Name : " + displayUnit,
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
            SizedBox(height: 36),
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
                    displayPrevious,
                    style: TextStyle(
                      letterSpacing: 1.0,
                      // default is 0.0
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(" - Last Read  ",
                    style: TextStyle
                      (
                      letterSpacing: 1.0,
                      // default is 0.0
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 36),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: id,
                decoration: InputDecoration(
                  hintText: 'name',
                ),
              ),
            ),
            SizedBox(height: 36),



      ElevatedButton(
      child: Text(
      "Next".toUpperCase(),
      style: TextStyle(fontSize: 14)
      ),
      style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(
      Colors.white),
      backgroundColor: MaterialStateProperty.all<Color>(
      Colors.pink),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
      side: BorderSide(color: Colors.pink)
      )
      )
      ),
      onPressed: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Home()));
      }
      ),




            ElevatedButton(
                child: Text(
                    "Details".toUpperCase(),
                    style: TextStyle(fontSize: 14)
                ),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.pink),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.pink)
                        )
                    )
                ),
                onPressed: () async {

                }
            ),


          ]


      );

    }

    ),



    );
  }
}



