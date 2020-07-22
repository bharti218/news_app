import 'package:flutter/material.dart';

class DarkMode{
  static ThemeData darkModeThemeData(){
    return ThemeData(
      scaffoldBackgroundColor:  Color(0xff1F1F1F),
      primaryColor: Colors.black,
    );
  }

  static TextStyle darkModeHeadlineTextStyle(Color c){
    return TextStyle(
      fontSize: 17,
      color: c,
      fontWeight: FontWeight.w700,
    );
  }
}

class LightMode{
   static ThemeData lightModeThemeData(){
    return ThemeData(
      scaffoldBackgroundColor:  Colors.white,
      primaryColor: Colors.white,
    );
  }
   static TextStyle lightModeHeadlineTextStyle(){
     return TextStyle(
       fontSize: 17,
       color: Colors.black,
       fontWeight: FontWeight.w100,
     );
   }

}





