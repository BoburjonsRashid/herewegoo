import 'dart:async';

import 'package:flutter/material.dart';
import 'package:herewegoo/pages/signin_page.dart';

import '../service/auth_service.dart';
import 'main_page.dart';

class SplashPage extends StatefulWidget {
  static const String id = "splash_page";

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initTimer ();
  }
  void _initTimer (){
    Timer(const Duration (seconds: 2), (){
      _callNextPage ();
    }); }
  _callNextPage () {
    if (AuthService.isLoggedIn()) {
      Navigator.pushReplacementNamed(context, MainPage.id);
    }
    else{
      Navigator.pushReplacementNamed (context, SignInPage.id);
    }
  }
  //   if (isLoggedIn) {
  //     Navigator.pushReplacementNamed (context, MainPage.id);}
  //     else{
  //       Navigator.pushReplacementNamed (context, SignInPage.id);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,

        child:
        const Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Expanded(
            child: Center(
              child: Text(
                "Welcome",
                style: TextStyle(color: Colors.red, fontSize: 35),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}