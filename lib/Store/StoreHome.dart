import 'dart:async';

import 'package:amazon/Counters/CartItemCounter.dart';
import 'package:amazon/Widgets/myDrawer.dart';
import 'package:amazon/admin/cartpage.dart';
import 'package:flutter/material.dart';
import 'package:amazon/Authentication/authentication.dart';


double width;

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.pink, Colors.lightGreenAccent],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0,1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          title: Text(
            "ecommerce",
            style: TextStyle(fontSize: 55, color: Colors.white, fontFamily: "signature"),
          ),
          centerTitle: true,
         actions: [
           Stack(
             children: [
                IconButton(icon:Icon(Icons.shopping_cart, color: Colors.pink,), onPressed:(){
                  Route route = MaterialPageRoute(builder:(c) => CartPage());
                  Navigator.pushReplacement(context, route);
                },
                ),
               Positioned(child: Stack(
                 children: [
                   Icon(Icons.brightness_1,
                   size: 20.0,
                   color: Colors.green,),

                 ],
               ))
             ],
           )
         ],
        ),

        drawer: MyDrawer(),
      ),
    );
  }
}


Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}){
  return InkWell();
}

class ItemModel {
}