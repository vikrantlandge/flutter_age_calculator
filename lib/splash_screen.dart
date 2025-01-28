import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled2/age_calculator_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AgeCalculatorScreen() ));
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
     mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             // Icon(Icons.calendar_today_rounded,size: 300,color: Colors.blue,)
              Image.asset("assets/ageCalculator.png",width: 300,)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 100),
            child: Text("Developed by... Vikrant",style: TextStyle(color: Colors.teal),textAlign: TextAlign.end,),
          )
        ],
      )),
    );
    
  }
}
