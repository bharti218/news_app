import 'package:flutter/material.dart';
import 'package:news_app/helper/saveAndFetchSharedPrefs.dart';
import 'package:news_app/views/home.dart';

import 'helper/widgetStyle.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  bool isDark;
  bool isDark;

  getStatus(){
    print(isDark);
    getMode();
    return isDark;
  }

  getMode() async {
    await SharedPrefs.getIsDarkSharedPrefs().then((val) {
      setState(() {
        isDark = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner:  false,
      theme: getStatus()==true ? DarkMode.darkModeThemeData() : LightMode.lightModeThemeData(),

      home: Home(),
    );
  }
}

