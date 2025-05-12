import 'dart:async';
import 'package:flutter/material.dart';
import 'package:note_hub/dashboard_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  // Splash screen logic...
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(    //Splash screen design...
          height: 350,
          width: 350,
          child: Image.asset('assets/images/Splash_01.png')
        ),
      )
    );
  }
}
