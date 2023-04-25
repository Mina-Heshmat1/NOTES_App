import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../layout/todoapp/todolayout.dart';
import '../../shared/styles/colors.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    new Future.delayed(
      const Duration(seconds:3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TodoLayout()),
      ),
    );
    return Scaffold(
      backgroundColor: bLUY,

      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.verified,
            size: 100,
            color: Colors.white,
          ),

          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                "Faite par \n MINA_HESHMAT",
                textStyle:  TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'DancingScript',
                ),
                textAlign: TextAlign.center,
                speed: const Duration(milliseconds: 100),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
//Text("from \n MINA_HESHMAT",style: TextStyle(fontSize:18,color: Colors.white,fontFamily:'Bobbers',),textAlign:TextAlign.center, ),
