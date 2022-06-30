import 'package:amazon/Config/config.dart';
import 'package:flutter/material.dart';

class CartItemCounter extends ChangeNotifier{

  int _counter = EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length-1;
  int get count => _counter;
}