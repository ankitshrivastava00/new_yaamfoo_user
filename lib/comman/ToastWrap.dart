import 'dart:async';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:yaamfoo/constant/Constant.dart';
import 'package:yaamfoo/constant/Padding_Wrap.dart';
import 'package:yaamfoo/constant/TextView_Wrap.dart';

class ToastWrap {
  /*static showToast(msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 5,
        fontSize: 12.5,
        backgroundColor: Colors.black,
        textColor: Colors.white);
  }
*/
  static showToastGreen(msg, context) {
    Timer _timer;

    print("timer on");
    _timer = new Timer(const Duration(milliseconds: 5000), () async {
      print("timer off");

      Navigator.pop(Constant.applicationContext);
    });

    showDialog(
        context: context,
        builder: (_) => new WillPopScope(
            onWillPop: () {
              Navigator.pop(context);
            },
            child: new GestureDetector(
              onHorizontalDragUpdate: (GestureDragUpdateCallback) {
                _timer.cancel();
                Navigator.pop(context);
              },
              child: new Scaffold(
                backgroundColor: Colors.transparent,
                body: new Stack(
                  children: <Widget>[
                    new Positioned(
                        right: 0.0,
                        top: 55.0,
                        left: 0.0,
                        child: new Container(
                          height: 65.0,
                          padding: new EdgeInsets.fromLTRB(12.0, 10.0, 0, 10.0),
                          color: new Color(0xffF1EDC3),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: ' ',
                                  style: new TextStyle(
                                    color: new Color(0xff408738),
                                    height: 1.2,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: msg,
                                      style: new TextStyle(
                                          color: new Color(0xff408738),
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: Constant.customRegular),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              onTap: () {
                _timer.cancel();
                Navigator.pop(context);
              },
            )));
  }

  static showToas(msg, context) {
    Timer _timer;

    print("timer on");
    _timer = new Timer(const Duration(milliseconds: 300), () async {
      print("timer off");
      Navigator.pop(context);
    });

    showDialog(
        context: context,
        builder: (_) => new WillPopScope(
            onWillPop: () {
              Navigator.pop(context);
            },
            child: new GestureDetector(
              onHorizontalDragUpdate: (GestureDragUpdateCallback) {
                _timer.cancel();
                Navigator.pop(context);
              },
              child: new Scaffold(
                backgroundColor: Colors.transparent,
                body: new Stack(
                  children: <Widget>[
                    new Positioned(
                        right: 0.0,
                        top: 55.0,
                        left: 0.0,
                        child: new Container(
                          height: 65.0,
                          padding: new EdgeInsets.fromLTRB(12.0, 10.0, 0, 10.0),
                          color: new Color(0xffF1EDC3),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: ' ',
                                  style: new TextStyle(
                                    color: new Color(0xff408738),
                                    height: 1.2,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: msg,
                                      style: new TextStyle(
                                          color: new Color(0xff408738),
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: Constant.customRegular),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              onTap: () {
                _timer.cancel();
                Navigator.pop(context);
              },
            )));
  }

  static showToast1Sec(msg, context) {
    Timer _timer;
    print("timer on");
    _timer = new Timer(const Duration(milliseconds: 1000), () async {
      print("timer off");
      Navigator.pop(context);
    });

    showDialog(
        context: context,
        builder: (_) => new WillPopScope(
            onWillPop: () {
              Navigator.pop(context);
            },
            child: new GestureDetector(
              onHorizontalDragUpdate: (GestureDragUpdateCallback) {
                _timer.cancel();
                Navigator.pop(context);
              },
              child: new Scaffold(
                backgroundColor: Colors.transparent,
                body: new Stack(
                  children: <Widget>[
                    new Positioned(
                        right: 0.0,
                        top: 55.0,
                        left: 0.0,
                        child: new Container(
                          height: 65.0,
                          padding: new EdgeInsets.fromLTRB(12.0, 10.0, 0, 10.0),
                          color: new Color(0xffF1EDC3),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: ' ',
                                  style: new TextStyle(
                                    color: new Color(0xffFF0101),
                                    height: 1.2,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: msg,
                                      style: new TextStyle(
                                          color: new Color(0xffFF0101),
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: Constant.customRegular),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              onTap: () {
                _timer.cancel();
                Navigator.pop(context);
              },
            )));
  }

  static showToastLong(msg, context) {
    Timer _timer;

    print("timer on");
    _timer = new Timer(const Duration(milliseconds: 5000), () async {
      print("timer off");
      Navigator.pop(context);
    });

    showDialog(
        context: context,
        builder: (_) => new WillPopScope(
            onWillPop: () {
              Navigator.pop(context);
            },
            child: new GestureDetector(
              onHorizontalDragUpdate: (GestureDragUpdateCallback) {
                _timer.cancel();
                Navigator.pop(context);
              },
              child: new Scaffold(
                backgroundColor: Colors.transparent,
                body: new Stack(
                  children: <Widget>[
                    new Positioned(
                        right: 0.0,
                        top: 55.0,
                        left: 0.0,
                        child: new Container(
                          height: 65.0,
                          padding: new EdgeInsets.fromLTRB(12.0, 10.0, 0, 10.0),
                          color: new Color(0xffF1EDC3),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: 'ERROR: ',
                                  style: new TextStyle(
                                    color: new Color(0xffFF0101),
                                    height: 1.2,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: msg,
                                      style: new TextStyle(
                                          color: new Color(0xffFF0101),
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: Constant.customRegular),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              onTap: () {
                _timer.cancel();
                Navigator.pop(context);
              },
            )));
  }

  static showToast(msg, context) {
    Timer _timer;

    print("timer on");
    _timer = new Timer(const Duration(milliseconds: 5000), () async {
      print("timer off");

      Navigator.pop(Constant.applicationContext);
    });

    showDialog(
        context: context,
        builder: (_) => new WillPopScope(
            onWillPop: () {
              Navigator.pop(context);
            },
            child: new GestureDetector(
              onHorizontalDragUpdate: (GestureDragUpdateCallback) {
                _timer.cancel();
                Navigator.pop(context);
              },
              child: new Scaffold(
                backgroundColor: Colors.transparent,
                body: new Stack(
                  children: <Widget>[
                    new Positioned(
                        right: 0.0,
                        top: 55.0,
                        left: 0.0,
                        child: new Container(
                          height: 65.0,
                          padding: new EdgeInsets.fromLTRB(12.0, 10.0, 0, 10.0),
                          color: new Color(0xffF1EDC3),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: 'ERROR: ',
                                  style: new TextStyle(
                                    color: new Color(0xffFF0101),
                                    height: 1.2,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: msg,
                                      style: new TextStyle(
                                          color: new Color(0xffFF0101),
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: Constant.customRegular),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              onTap: () {
                _timer.cancel();
                Navigator.pop(context);
              },
            )));
  }

  static showSucess(msg, context) {
    Timer _timer;

    print("timer on");
    _timer = new Timer(const Duration(milliseconds: 3000), () async {
      print("timer off");

      Navigator.pop(Constant.applicationContext);
    });

    showDialog(
        context: context,
        builder: (_) => new WillPopScope(
            onWillPop: () {
              Navigator.pop(context);
            },
            child: new GestureDetector(
              onHorizontalDragUpdate: (GestureDragUpdateCallback) {
                _timer.cancel();
                Navigator.pop(context);
              },
              child: new Scaffold(
                backgroundColor: Colors.transparent,
                body: new Stack(
                  children: <Widget>[
                    new Positioned(
                        right: 0.0,
                        top: 55.0,
                        left: 0.0,
                        child: new Container(
                          height: 50.0,
                          padding: new EdgeInsets.fromLTRB(12.0, 10.0, 0, 10.0),
                          color: Colors.lightGreen[300],
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: '',
                                  style: new TextStyle(
                                    color: new Color(0xffFF0101),
                                    height: 1.2,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: msg,
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: Constant.customRegular),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              onTap: () {
                _timer.cancel();
                Navigator.pop(context);
              },
            )));
  }

  static showToastWithICon(context) {
    Timer _timer;

    print("timer on");
    _timer = new Timer(const Duration(milliseconds: 5000), () async {
      print("timer off");

      Navigator.pop(Constant.applicationContext);
    });

    showDialog(
        context: context,
        builder: (_) => new WillPopScope(
            onWillPop: () {
              Navigator.pop(context);
            },
            child: new GestureDetector(
              onHorizontalDragUpdate: (GestureDragUpdateCallback) {
                _timer.cancel();
                Navigator.pop(context);
              },
              child: new Scaffold(
                backgroundColor: Colors.transparent,
                body: new Stack(
                  children: <Widget>[
                    new Positioned(
                        right: 0.0,
                        top: 55.0,
                        left: 0.0,
                        child: new Container(
                          height: 65.0,
                          padding: new EdgeInsets.fromLTRB(12.0, 10.0, 0, 10.0),
                          color: new Color(0xffF1EDC3),
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                child: PaddingWrap.paddingfromLTRB(
                                    10.0,
                                    10.0,
                                    11.0,
                                    10.0,
                                    new Image.asset(
                                      "assets/newDesignIcon/error.png",
                                      width: 22.0,
                                      height: 20.0,
                                    )),
                                flex: 0,
                              ),
                              new Expanded(
                                  child: TextViewWrap.textViewMultiLine(
                                      "You have incomplete accomplishment(s) in your profile, kindly complete",
                                      TextAlign.start,
                                      new Color(0XFF090909),
                                      14.0,
                                      FontWeight.normal,
                                      2),
                                  flex: 1)
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              onTap: () {
                _timer.cancel();
                Navigator.pop(context);
              },
            )));
  }
}