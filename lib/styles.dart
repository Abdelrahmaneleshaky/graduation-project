import 'package:flutter/material.dart';

abstract class Styles
{
  static OutlineInputBorder textFormFieldOutlineInputBorder() => OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: const BorderSide(color: Colors.green, width: 3.5));
  static TextStyle errorStyle = TextStyle(color:Colors.white, fontSize: 13, fontWeight: FontWeight.bold);
  static TextStyle textFormFieldStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey);
  static TextStyle tabBarStyles = TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold);
  static TextStyle listItemStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 17);
  static TextStyle styleOfCodeField = TextStyle(color: Colors.grey, fontWeight: FontWeight.bold);
  static TextStyle styleOfDropDown = TextStyle(color: Colors.grey, fontWeight: FontWeight.bold);
}