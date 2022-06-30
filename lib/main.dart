import 'dart:async';

import 'package:amazon/Authentication/authentication.dart';
import 'package:amazon/Config/config.dart';
import 'package:amazon/Store/StoreHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "e-shope",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: SplashScreen()
    );
  }
}

class SplashScreen extends StatefulWidget {

  @override

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displaySplash();
  }

      displaySplash()
      {
      Timer(Duration(seconds: 5), () async {
        EcommerceApp.auth = FirebaseAuth.instance;
        if(await EcommerceApp.auth.currentUser != null)
          {
            Route route = MaterialPageRoute(builder: (_) => AuthenticScreen());
            Navigator.pushReplacement(context, route);
          }
        else
        {

          Route route = MaterialPageRoute(builder: (_) => StoreHome());
          Navigator.pushReplacement(context, route);
        }
      });
    }



  @override
  Widget build(BuildContext context) {
    return Material(
    child: Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [Colors.pink, Colors.lightGreenAccent],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )
      ),



      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/splashlogo.png"),
            SizedBox(height: 20.0,),
            Text("world largest and number online shop",
            style: TextStyle(color: Colors.white),)
          ],
        )
      )
    ),
    );
  }

}



