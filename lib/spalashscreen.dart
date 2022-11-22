import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:kavinie/wapper.dart';

class SplashScreenloder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  AnimatedSplashScreen(
            duration: 3000,
            splash: Image(image: AssetImage('assets/images/img.png')),
            nextScreen: wapper(),
            splashTransition: SplashTransition.fadeTransition,
            //pageTransitionType: PageTransitionType.scale,
            backgroundColor: Colors.white);
  }
}