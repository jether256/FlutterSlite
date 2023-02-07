import 'dart:async';

import 'package:flutter/material.dart';

import '../main/dashboard.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {

    Timer(const Duration(seconds: 3), () {

      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
        return const Dashboard();
      }));

    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:Container(
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     opacity: 100,
          //     image: AssetImage("assets/images/favi.png"),
          //     fit: BoxFit.cover,
          //   ),
          // ),
            child:  Padding(
              padding: const EdgeInsets.only(left:20,right: 20),
              child: Center(child: Image.asset('assets/images/pill.png',height:200,)),
            )
        ),
      ),
    );
  }
}
