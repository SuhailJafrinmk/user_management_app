import 'package:flutter/material.dart';

class AppThemeSetter{
  static TextStyle setTextStyle({required double size,required FontWeight fontWeight,Color color=Colors.black}){
    return TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
    );
  }
  static setHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }
  static setWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
  static ThemeData appTheme=ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.teal,
      toolbarHeight: 80
    ),
    scaffoldBackgroundColor: Colors.grey.shade200,
    
  );
}