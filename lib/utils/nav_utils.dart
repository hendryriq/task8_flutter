import 'package:flutter/material.dart';

class NavUtils{
  static Future goTo(BuildContext context, Widget widget){
    return Navigator.push(context, MaterialPageRoute(builder: (_) => widget));
  }

  static Future goAll(BuildContext context, Widget widget){
    return Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_) => widget), (route) => false);
  }
}