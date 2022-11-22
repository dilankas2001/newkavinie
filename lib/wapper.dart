
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:kavinie/registerscreen.dart';



import 'auth_checker.dart';
import 'login_screen.dart';

class wapper extends StatefulWidget {
  const wapper({Key? key}) : super(key: key);

  @override
  State<wapper> createState() => _wapperState();
}

class _wapperState extends State<wapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //width: 336,
      //height: 611,
      //constraints: BoxConstraints(
        //maxHeight: double.infinity,
     // ),

      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[

            Container(
        constraints: BoxConstraints(
        maxHeight: double.infinity,
          maxWidth: double.infinity,
        ),

              //width: 336,
             // height: 611,
             // color: Colors.white,
              //padding: const EdgeInsets.only(left: 57, right: 56, top: 59, bottom: 122, ),
              child: Column(
               // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  Container(
                    width: 223,
                    height: 215,
                   child: Image(image: AssetImage('assets/images/img.png')),
                  ),
                  SizedBox(height: 57.50),
                  Container(
                    width: 300,
                    height: 50,
                    child: Row(
                      //mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[


                        Row(
                         // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:[
                            SignInButtonBuilder(
                              text: 'SignIn With Email',
                              icon: Icons.email,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const AuthChecker()),
                                );
                              },
                              backgroundColor: Colors.pinkAccent,
                              width: 220.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 57.50),
                  Container(
                    height: 50,
                    width: 300,
                    child: Row(
                     // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[


                        Row(
                          //mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children:[
                            SignInButtonBuilder(
                              text: 'Register With Email',
                              icon: Icons.app_registration,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const  RegisterScreen()),
                                );
                              },
                              backgroundColor: Colors.greenAccent,
                              width: 220.0,
                            ),


                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
