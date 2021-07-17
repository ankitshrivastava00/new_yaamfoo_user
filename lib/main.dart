import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaamfoo/activity/StartScreen.dart';
import 'package:yaamfoo/activity/login.dart';
import 'package:yaamfoo/constant/Constant.dart';
import 'package:yaamfoo/drawer/tabs/tabspage.dart';
import 'package:yaamfoo/values/ColorValues.dart';
import 'package:flutter/services.dart';

void main() {

  runApp(
      new MaterialApp(
        title: 'Yaamfoo',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primaryColor: ColorValues.TEXT_COLOR,

        ), home: new MyApp(),
        routes: <String, WidgetBuilder>{
          '/startscreen': (BuildContext context) => new StartScreen(),
          '/HomeScreen': (BuildContext context) => TabsPage(selectedIndex: 0)
        },
      ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();

}

class _MyAppState extends State<MyApp>  {

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  Future navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String status = prefs.getString(Constant.LOGIN_STATUS).toString();
    print(status);

    if(status == 'true'){
      Navigator.of(context).pushReplacementNamed('/HomeScreen');
    }else{
      Navigator.of(context).pushReplacementNamed('/startscreen');
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
   // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //  statusBarColor: Color(0xFF2E7D32),
  //  ));
    return new Scaffold(
      backgroundColor: Color(0xff00F9FF),
      body: new Center(

        child: new Image.asset('image/logo.png'),
      ),
    );
  }
}