import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:yaamfoo/activity/address/AddAddress.dart';
import 'package:yaamfoo/activity/address/AddressBook.dart';
import 'package:yaamfoo/activity/login.dart';
import 'package:yaamfoo/activity/order/OrderHistory.dart';
import 'package:yaamfoo/activity/profilemenu/NotificationList.dart';
import 'package:yaamfoo/activity/profilemenu/edit_profile.dart';
import 'package:yaamfoo/comman/Connectivity.dart';
import 'package:yaamfoo/constant/Constant.dart';
import 'package:yaamfoo/constant/Padding_Wrap.dart';
import 'package:yaamfoo/drawer/sidemenu/side_menu.dart';
import 'package:yaamfoo/values/ColorValues.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isSwitched = true;
  SharedPreferences prefs;
  var isLoading=true;
  String _name,_email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }
  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {

      _email=prefs.getString(Constant.USER_EMAIL);
      _name=prefs.getString(Constant.USER_NAME);
      isLoading=false;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return
              new InkWell(
                child:Container(
                  padding: EdgeInsets.all(20.0),
                  //  margin: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                  child: new Image.asset('image/back_arrow.png',
                  ),
                  width: 10.0,
                  height: 10.0,
                ),
                onTap: ()=>Scaffold.of(context).openDrawer(),
              );
          },
        ),
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: ColorValues.TEXT_COLOR,
        centerTitle: true,
        title: new Text(
          "Profile",
          style: new TextStyle(
              color: Color(ColorValues.WHITE),
              fontWeight: FontWeight.w600,
              fontFamily: "customRegular",
              fontSize: 18.0),
        ),
      ),
      body:
      isLoading?new Center(child:new CircularProgressIndicator(
        valueColor:AlwaysStoppedAnimation<Color>(ColorValues.TEXT_COLOR),

      )):
      SingleChildScrollView(
        child: Center(
          child:     Column(children: [
            Container(

            decoration: BoxDecoration(

              //  color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('image/corver.png'))),
            //  color: Color(0xff00F9FF),
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120.0,
                  child:
                  PaddingWrap.paddingfromLTRB(
                      18.0,
                      20.0,
                      0.0,
                      0.0,
                       new Row(
                          children: <Widget>[
                            new Center(
                              child:  new Container(
                                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
                                child: new Image.asset('image/profil_pic.png'),
                                width: 50.0,
                                height: 50.0,
                              ),
                            ),

                            new Padding(
                              padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                              child:
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  new Container(
                                    margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 3.0),
                                    alignment: Alignment.centerLeft,
                                    child:
                                    Text(_name,

                                      style: TextStyle(
                                        color: Color(ColorValues.WHITE),
                                        fontSize: 15.0,

                                        fontFamily: "customSemiBold",

                                      ),
                                    ),
                                  ),
                                  new Container(
                                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 5.0),
                                    alignment: Alignment.centerLeft,
                                    child:
                                    Text(_email,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(ColorValues.WHITE),
                                        fontSize: 13.0,
                                        fontFamily: "customLight",

                                      ),),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                ),
              ],
            ),
          ),

            PaddingWrap.paddingfromLTRB(
          15.0,
          15.0,
          15.0,
          15.0,
            Container(
           //   height: 220,
              width: double.maxFinite,
              child: Card(
                elevation: 5,
                child:
                PaddingWrap.paddingfromLTRB(
                    10.0,
                    10.0,
                    10.0,
                    10.0,                new Column(children: [

                  new Container(
                    alignment: FractionalOffset(0.0, 0.5),
                    child: new Text(
                      "My Account",
                      style: TextStyle(
                        fontSize: 13.0,
                        color: ColorValues.TEXT_COLOR,
                        fontFamily: "customRegular",
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),

                  PaddingWrap.paddingfromLTRB(
                      0.0,
                      20.0,
                      0.0,
                      0.0,
                      new InkWell(
                          child:
                          new Row(
                            children: <Widget>[
                            Expanded(
                            flex: 1,
                            child:  Image.asset(
                                'image/user.png',
                                height: 15.0,
                                width: 15.0,
                              ),
                              ),
                          Expanded(
                            flex: 8,
                            child:new Padding(
                                padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                child: new Text(
                                  "Manage Profile",
                                  style: TextStyle(
                                      fontFamily: 'customLight',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0,
                                      color: Color(ColorValues.HEADING_COLOR_EDUCATION)),
                                ),
                                ),
                              ),
                          Expanded(
                            flex: 1,
                          child:
                          RotatedBox(
                            quarterTurns: 2,
                            child: new Image.asset('image/back_arrow.png',
                                height: 10.0,
                                width: 10.0,
                              color: ColorValues.TEXT_COLOR,
                              ),
                              ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        EditProfile()));

                          }
                      )
                  ),
                  PaddingWrap.paddingfromLTRB(
                      0.0,
                      20.0,
                      0.0,
                      0.0,
                      new InkWell(
                          child: new Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child:  Image.asset(
                                  'image/shape.png',
                                  height: 15.0,
                                  width: 15.0,
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child:new Padding(
                                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                  child: new Text(
                                    "Delivery Address",
                                    style: TextStyle(
                                        fontFamily: 'customLight',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0,
                                        color: Color(ColorValues.HEADING_COLOR_EDUCATION)),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child:
                                RotatedBox(
                                  quarterTurns: 2,
                                  child: new Image.asset('image/back_arrow.png',
                                    height: 10.0,
                                    width: 10.0,
                                    color: ColorValues.TEXT_COLOR,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AddressBook()));
                          }
                      )
                  ),
                  PaddingWrap.paddingfromLTRB(
                      0.0,
                      20.0,
                      0.0,
                      0.0,
                      new InkWell(
                          child: new Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child:  Image.asset(
                                  'image/order_history.png',
                                  height: 15.0,
                                  width: 15.0,
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child:new Padding(
                                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                  child: new Text(
                                    "Order History",
                                    style: TextStyle(
                                        fontFamily: 'customLight',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0,
                                        color: Color(ColorValues.HEADING_COLOR_EDUCATION)),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child:
                                RotatedBox(
                                  quarterTurns: 2,
                                  child: new Image.asset('image/back_arrow.png',
                                    height: 10.0,
                                    width: 10.0,
                                    color: ColorValues.TEXT_COLOR,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OrderHistory()));
                          }
                      )
                  ),
                  new Container(
                    margin: EdgeInsets.only(top: 20.0),
                    alignment: FractionalOffset(0.0, 0.5),
                    child: new Text(
                      "Notification",
                      style: TextStyle(
                          fontSize: 13.0,
                          color: ColorValues.TEXT_COLOR,
                          fontFamily: "customRegular",
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),

                  PaddingWrap.paddingfromLTRB(
                      0.0,
                      20.0,
                      0.0,
                      0.0,
                      new InkWell(
                          child: new Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child:  Image.asset(
                                  'image/notification.png',
                                  height: 15.0,
                                  width: 15.0,
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child:new Padding(
                                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                  child: new Text(
                                    "Notification",
                                    style: TextStyle(
                                        fontFamily: 'customLight',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0,
                                        color: Color(ColorValues.HEADING_COLOR_EDUCATION)),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child:
                                Container(
                                  child: FlutterSwitch(
                                    width: 30.0,
                                    height: 15.0,
                                    valueFontSize: 0.0,
                                    toggleSize: 13.0,
                                    value: isSwitched,
                                    borderRadius: 30.0,
                                    activeColor: ColorValues.NOTIFICATION_BLUE,
                                    padding: 1.0,
                                    showOnOff: false,
                                    onToggle: (val) {
                                      setState(() {
                                        isSwitched = val;
                                      });
                                    },
                                  ),
                                ),
                                ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  //   builder: (context) => new DashBoardWidget()));
                                    builder: (context) =>
                                    new NotificationList()));

                          }
                      )
                  ),
                  new Container(
                    alignment: FractionalOffset(0.0, 0.5),
                    margin: EdgeInsets.only(top: 20.0),

                    child: new Text(
                      "Other",
                      style: TextStyle(
                          fontSize: 13.0,
                          color: ColorValues.TEXT_COLOR,
                          fontFamily: "customRegular",
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),

                  PaddingWrap.paddingfromLTRB(
                      0.0,
                      20.0,
                      0.0,
                      0.0,
                      new InkWell(
                          child: new Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child:  Image.asset(
                                  'image/setting.png',
                                  height: 19.0,
                                  width: 19.0,
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child:new Padding(
                                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                  child: new Text(
                                    "Setting",
                                    style: TextStyle(
                                        fontFamily: 'customLight',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0,
                                        color: Color(ColorValues.HEADING_COLOR_EDUCATION)),
                                  ),
                                ),
                              ),

                            ],
                          ),
                          onTap: () {

                          }
                      )
                  ),
                  PaddingWrap.paddingfromLTRB(
                      0.0,
                      20.0,
                      0.0,
                      20.0,
                      new InkWell(
                          child: new Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child:  Image.asset(
                                  'image/logout.png',
                                  height: 15.0,
                                  width: 15.0,
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child:new Padding(
                                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                  child: new Text(
                                    "Logout",
                                    style: TextStyle(
                                        fontFamily: 'customLight',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0,
                                        color: ColorValues.LOGOUT_TEXT),
                                  ),
                                ),
                              ),

                            ],
                          ),
                          onTap: () {
                          //  Navigator.of(context).pop();
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title:  Text('Logout',style: new TextStyle(
                                    color: ColorValues.TEXT_COLOR,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "customRegular",
                                  fontSize: 14.0),
                            ),
                                content:  Text('Do You Want to Logout',style: new TextStyle(
                                    color: ColorValues.TEXT_COLOR,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "customLight",
                                    fontSize: 13.0),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'Cancel'),
                                    child: Text('Cancel',style: new TextStyle(
                                    color: ColorValues.TEXT_COLOR,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "customLight",
                                    fontSize: 12.0),)),

                                  TextButton(
                                    onPressed: ()
                            {
                              Navigator.pop(context, 'OK');

                              prefs.setString(Constant.LOGIN_STATUS, "false");
                              Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Login()));
                            },
                                    child: Text('OK',style: new TextStyle(
                            color: ColorValues.TEXT_COLOR,
                            fontWeight: FontWeight.w600,
                            fontFamily: "customLight",
                            fontSize: 12.0),),
                                  ),
                                ],
                              ),
                            );                      }
                      )
                  ),
                ],)
              ),
              ),

            )
        )
          ],)
        ),
      ),
    );
  }
}