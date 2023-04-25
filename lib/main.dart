import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:notes/shared/Cubit/BlocObserver.dart';
import 'package:notes/shared/styles/colors.dart';
import 'modules/ٍSplash Screen/Splash Screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
        () {
      runApp (MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home:AnimatedSplashScreen(
          duration: 3000,
          splash:Text('TO_Do',style: TextStyle(fontSize: 60,fontWeight: FontWeight.w900,color: Colors.white),),
          backgroundColor:bLUYTOW,
          splashTransition: SplashTransition.slideTransition,
          nextScreen:SplashScreen()),
    );
  }
}