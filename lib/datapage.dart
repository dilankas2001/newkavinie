import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';



class Data extends StatefulWidget {
  const Data({Key? key}) : super(key: key);

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  String displayUnit= 'no signal';
  String displayTotal = 'no signal';
  String displayUsage = 'no signal';
  String displayPrevious = 'no signal';
  String displayName = 'no signal';
  @override

  final databse = FirebaseDatabase.instance.ref();
  late StreamSubscription _esp32;
  @override
  void initState() {
    // super.initState();
    _activateListeners();
  }

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
        displayTotal = ' $Total';
        displayUsage = ' $Usage';
        displayPrevious = '$Previous';
        displayName='$Name';
      });
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("EBMS"),
          backgroundColor:Colors.pink
      ),


      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 199,
            height: 185,
            child:Image(image: AssetImage('assets/images/img.png')),
          ),


                  Column(
                    //mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                        color: Color(0xffd9d9d9),
                        //padding: const EdgeInsets.only(left: 131, right: 152, top: 21, bottom: 15, ),
                        child: Row(
                          //mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:[

                            Text(
                              "Customer Name - "+displayName,
                              style: TextStyle(
                                letterSpacing: 1.0, // default is 0.0
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
                        //padding: const EdgeInsets.only(left: 135, right: 148, top: 21, bottom: 15, ),
                        child: Row(
                          //mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:[

                            Text(

                              displayUnit,

                              style: TextStyle(
                                letterSpacing: 1.0, // default is 0.0
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700,
                              ),
                            ), Text("- New Read  ",
                              style: TextStyle
                                (
                                letterSpacing: 1.0 ,// default is 0.0
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
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                        color: Color(0xffd9d9d9),
                        //padding: const EdgeInsets.only(left: 131, right: 152, top: 21, bottom: 15, ),
                        child: Row(
                          //mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:[
                            Text(
                              displayPrevious,
                              style: TextStyle(
                                letterSpacing: 1.0, // default is 0.0
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(" - Last Read  ",
                              style: TextStyle
                                (
                                letterSpacing: 1.0 ,// default is 0.0
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
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                        color: Color(0xffd9d9d9),
                        //padding: const EdgeInsets.only(left: 131, right: 152, top: 21, bottom: 15, ),
                        child: Row(
                          //mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:[
                            Text(
                              displayUsage,
                              style: TextStyle(
                                letterSpacing: 1.0, // default is 0.0
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(" Units Used This Period  ",
                              style: TextStyle
                                (
                                letterSpacing: 1.0 ,// default is 0.0
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
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                        color: Color(0xffd9d9d9),
                        //padding: const EdgeInsets.only(left: 131, right: 152, top: 21, bottom: 15, ),
                        child: Row(
                          //mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:[
                            Text("Rs."+displayTotal +".00",
                              style: TextStyle(
                                letterSpacing: 1.0, // default is 0.0
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text("Total Price In this TimePeriod",
                              style: TextStyle
                                (
                                letterSpacing: 1.0 ,// default is 0.0
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
            ),














    );
  }
}
