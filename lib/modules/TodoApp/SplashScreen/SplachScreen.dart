import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../layout/todoapp/todolayout.dart';

class SplachScreen extends StatefulWidget {

  @override
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void intistate() {
    super.initState();
    navigatetohome();
  }

  navigatetohome() async {
    await Future.delayed(Duration(microseconds: 6000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => TodoLayout()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 100,horizontal: 20,),
            child: Container(
              child: Center(child: Text("MINA",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w900,color: Colors.pink),)),
              color: Colors.yellowAccent,

            ),
          )
        ],
      ),
    );
  }
}

/*body: Column(
        children: [
          Container(
            color: Colors.orangeAccent,
            child: (
            Text("MINA_HESHMAT",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30,color: Colors.pink,),)
            ),
          ),
        ],
      ),*/
