import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yaamfoo/activity/maps/TrackOrder.dart';
import 'package:yaamfoo/activity/order/OrderHistory.dart';
import 'package:yaamfoo/drawer/sidemenu/side_menu.dart';
import 'package:yaamfoo/drawer/tabs/tabspage.dart';
import 'package:yaamfoo/values/ColorValues.dart';

class ThankYou extends StatefulWidget {
  @override
  _ThankYouState createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  @override
  Widget build(BuildContext context) {
    return    WillPopScope(
        onWillPop: () {
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) =>
                  TabsPage(selectedIndex: 2,)));
    },
    child:Scaffold(
      body: new Align(
        alignment: Alignment.center,
        child: new SingleChildScrollView(child: new Center(
          child: Column(
            children: [
              new Center(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
                        alignment: Alignment.center,
                        width: 200,
                        height: 200,
                        child: Image.asset("image/thank_you.png")),
                    new Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      child: Text(
                        "Thank You For Ordering!",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: ColorValues.TEXT_COLOR,
                          fontFamily: "customRegular",
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),  new Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0.0),
                      child: Text(
                        "Sit Back And Relax, Your Order Is Being Prepared.",
                        textAlign: TextAlign.center,
                        style: TextStyle(

                          fontSize: 15.0,
                          color: ColorValues.TEXT_COLOR,
                          fontFamily: "customLight",
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ), new Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 0.0),
                      child: Text(
                        "We Have Assigned Delivery Exclutive To Your Order. It Take 30 Min To Deliver For The Order To Arrive.",
                        textAlign: TextAlign.center,
                        style: TextStyle(

                          fontSize: 15.0,
                          color: ColorValues.TEXT_COLOR,
                          fontFamily: "customLight",
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                height: 40.0,
                margin: EdgeInsets.fromLTRB(20.0,50.0,20.0,50.0),

                child: Expanded(
                  child:
                  new InkWell(
                        child: new Container(
                          height: 40.0,
                          color: Colors.transparent,
                          child: new Container(
                              decoration: new BoxDecoration(
                                  color: ColorValues.TEXT_COLOR,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(10.0),
                                    topRight: const Radius.circular(10.0),
                                    bottomRight: const Radius.circular(10.0),
                                    bottomLeft: const Radius.circular(10.0),
                                  )),
                              child: new Center(
                                child: new Text(
                                  "Track Order",
                                  style: new TextStyle(
                                      color: ColorValues.BACKGROUND,
                                      fontFamily: "customRegular",
                                      fontSize: 12.0),
                                ),
                              )),
                        ),
                        onTap: () {

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => TrackOrder()),
                          );
                          //   subtractNumbers(context);
                        },
                      ),
                ),
              ),
            ],
          ),
          ),
        ),
      ),
      ),
    );
  }
}