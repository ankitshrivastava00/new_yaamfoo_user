import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaamfoo/activity/login.dart';
import 'package:yaamfoo/constant/Padding_Wrap.dart';
import 'package:yaamfoo/drawer/tabs/tabspage.dart';
import 'package:yaamfoo/values/ColorValues.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaamfoo/activity/OtpVerify.dart';
import 'package:yaamfoo/activity/SignUp.dart';
import 'package:yaamfoo/comman/ApiConstant.dart';
import 'package:yaamfoo/comman/CustomProgressLoader.dart';
import 'package:yaamfoo/comman/ToastWrap.dart';
import 'package:yaamfoo/constant/Constant.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  int _counter = 0;
  bool obscureText = true, passwordVisible = false;

  TextEditingController em = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  String reply="";
  String userId,name,mobile,email,address,password;
  var isLoading= true;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userId=prefs.getString(Constant.USER_ID);
      mobile=prefs.getString(Constant.USER_MOBILE);

      name= prefs.getString(Constant.USER_NAME);
      email= prefs.getString(Constant.USER_EMAIL);
      isLoading=false;
     // getData(prefs.getString(Constant.USER_ID));
    });


  }

  void getData  (id) async{
    try{




        try {
          print("body+++++");
        //  CustomProgressLoader.showLoader(context);
          var url =Uri.parse(ApiConstant.UPDATE_PROFILE+'${id}/user-details/');
          Map<String, String> headers = {"Content-type": "application/json"};

          // make GET request
          Response response =
          await get(url, headers: headers);
          // check the status code for the result
          // this API passes back the id of the new item added to the body
          String body = response.body;
         // CustomProgressLoader.cancelLoader(context);
          var data = json.decode(body);
//          if (data["status"].toString() == "201") {


setState(() {

  isLoading= true;

});
       /*   } else {
            Fluttertoast.showToast(
              msg:Constant.BOTH_NU_EM_V,
              toastLength: Toast.LENGTH_SHORT,
              //    gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              //  backgroundColor: Colors.red,
              //   textColor: Colors.white,
              //  fontSize: 16.0
            );
            //ToastWrap.showSucess("User not registered", context);
            // ToastWrap.showSucess("Number Not Register. Please Sign Up", context);
          }*/
          //  print("body+++++" + body.toString());
        } catch (e) {
          print("Error+++++" + e.toString());
          CustomProgressLoader.cancelLoader(context);



      }

    } catch (e) {
      print(e.toString());
    }
  }

  void _submitTask() async{
    try{



      final form = formKey.currentState;
      form.save();

      if(name.isEmpty){
        setState(() {
          Fluttertoast.showToast(
            msg:Constant.FIRST_NAME_VALIDATION,
            toastLength: Toast.LENGTH_SHORT,
            //    gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            //  backgroundColor: Colors.red,
            //   textColor: Colors.white,
            //  fontSize: 16.0
          );
        });
      }else if(mobile.isEmpty){
        setState(() {
          Fluttertoast.showToast(
            msg:Constant.MOBILE_VALIDATION,
            toastLength: Toast.LENGTH_SHORT,
            // gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            //   backgroundColor: Colors.red,
            //   textColor: Colors.white,
            // fontSize: 1.0
          );
        });

      }else if(!email.contains('@')){
        Fluttertoast.showToast(
          msg:Constant.EMAIL_VALIDATION,
          toastLength: Toast.LENGTH_SHORT,
          // gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          //  backgroundColor: Colors.red,
          //   textColor: Colors.white,
          //  fontSize: 16.0
        );

      }else{

        try {
          print("body+++++");
          CustomProgressLoader.showLoader(context);
          var url =Uri.parse(ApiConstant.UPDATE_PROFILE+'${userId}/user-details/');
          Map<String, String> headers = {"Content-type": "application/json"};
          Map map = {
              "first_name": name,
              "last_name": name,
              "email": email,
              "phone_number": mobile,
              "latitude": null,
              "longitude": null,
              "otp": null,
          };



          // make POST request
          Response response =
          await put(url, headers: headers, body: json.encode(map));
          // check the status code for the result
          // this API passes back the id of the new item added to the body
          String body = response.body;
          CustomProgressLoader.cancelLoader(context);
          var data = json.decode(body);
         // if (data["status"].toString() == "201") {
            /* {
              "message": "Login successfully",
    "user": {
    "username": "username",
    "first_name": "rahul",
    "last_name": "",
    "email": "superadmin@gsms.com",
    "user_type": "CUSTOMER",
    "phone_number": "9713198098",
    "latitude": null,
    "longitude": null,
    "otp": "123456"
    },
    "token": "07eb54629b8cbf30eb8ee150b53333037fba239b",
    "status": 201
    }*/


            prefs.setString(Constant.USER_MOBILE, data['phone_number'].toString());
            prefs.setString(Constant.USER_NAME, data['first_name']);
            prefs.setString(Constant.USER_EMAIL, data['email']);

          Fluttertoast.showToast(
            msg:Constant.UPDATE_PROFILE,
            toastLength: Toast.LENGTH_SHORT,
            //    gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            //  backgroundColor: Colors.red,
            //   textColor: Colors.white,
            //  fontSize: 16.0
          );


         /* } else {
            Fluttertoast.showToast(
              msg:Constant.BOTH_NU_EM_V,
              toastLength: Toast.LENGTH_SHORT,
              //    gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              //  backgroundColor: Colors.red,
              //   textColor: Colors.white,
              //  fontSize: 16.0
            );
            //ToastWrap.showSucess("User not registered", context);
            // ToastWrap.showSucess("Number Not Register. Please Sign Up", context);
          }*/
          //  print("body+++++" + body.toString());
        } catch (e) {
          print("Error+++++" + e.toString());
          CustomProgressLoader.cancelLoader(context);

        }

      }

    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    return new WillPopScope(
       onWillPop: (){
         Navigator.pushReplacement(
             context,
             new MaterialPageRoute(
                 builder: (BuildContext context) =>
                     TabsPage(selectedIndex: 3)));
       },
        child:
        new Scaffold(
          key: scaffoldKey,

          appBar:
          new AppBar(
            elevation: 0.0,
            leading: new InkWell(
              child:Container(
                padding: EdgeInsets.all(20.0),
                //  margin: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                child: new Image.asset('image/back_arrow.png',
                  width: 10.0,
                  height:10,
                  color: ColorValues.TEXT_COLOR,

                ),

              ),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            TabsPage(selectedIndex: 3)));
              },
            ),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            centerTitle: true,

            actions: [
              new InkWell(
                child:Container(
                  padding: EdgeInsets.all(20.0),
                  //  margin: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                  child: Text(
                    'Save',
                    style: new TextStyle(
                        color: ColorValues.TEXT_COLOR,
                        fontWeight: FontWeight.w600,
                        fontFamily: "customRegular",
                        fontSize: 13.0),
                  ),

                ),
                onTap: () {
                  _submitTask();
                },
              ),
            ],
          ),

          body: isLoading? new CircularProgressIndicator(
            valueColor:AlwaysStoppedAnimation<Color>(ColorValues.TEXT_COLOR),

          ):SingleChildScrollView(
            child: Form(
    key: formKey,
    child:Center(
              child:Container(
                //  color: Color(0xff00F9FF),
                child: Column(
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                      child: new Image.asset('image/profil_pic.png'),
                width: 50.0,
                height: 50.0,
              
                      //    heig ht: 80.0,
                    ),

              PaddingWrap.paddingfromLTRB(
                15.0,
                50.0,
                15.0,
                15.0,              new Card(child:
                  new Column(
                    children: [
                    new Container(
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 0.0),
                      alignment: FractionalOffset(0.0, 0.5),
                      child: new Row(children: [
                        new Container(
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                          child: new Image.asset('image/user1.png'),
                          width: 15.0,
                          height: 15.0,

                          //    heig ht: 80.0,
                        ),
                        new Text(
                          "Name",
                          style: TextStyle(
                            fontSize: 13.0,
                            color: ColorValues.HINT_TEXT_COLOR,
                            fontFamily: "customRegular",

                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],)
                    ),
                    new Container(
                     // height: 40.0,

                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                      child:                       new Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                            child: new TextFormField(
                              textAlign: TextAlign.start,
                              initialValue: name,
                              onSaved: (valueName) => name = valueName,

                              maxLines: 1,
                              style: TextStyle(
                                color: ColorValues.TEXT_COLOR,
                                fontSize: 15.0,
                                fontFamily: "customLight",

                              ),
                              decoration: InputDecoration(
                               // fillColor: Colors.white, filled: true,
                                border: InputBorder.none,




                              ),
                            ),
                            decoration: new BoxDecoration(

                                border: new Border(

                                    bottom: new BorderSide(
                                        color: ColorValues.HINT_TEXT_COLOR,
                                        ))),
                          ))

                      ,
                    ),

                      new Container(
                          margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 0.0),
                          alignment: FractionalOffset(0.0, 0.5),
                          child: new Row(children: [
                            new Container(
                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                              child: new Image.asset('image/phone.png'),
                              width: 15.0,
                              height: 15.0,

                              //    heig ht: 80.0,
                            ),
                            new Text(
                              "Phone",
                              style: TextStyle(
                                fontSize: 13.0,
                                color: ColorValues.HINT_TEXT_COLOR,
                                fontFamily: "customRegular",

                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],)
                      ),
                      new Container(
                        // height: 40.0,

                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                        child:                       new Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                              child: new TextFormField(
                                keyboardType: TextInputType.phone,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),

                                ],
                                textAlign: TextAlign.start,
                                initialValue: mobile,
                                onSaved: (valueMobile) => mobile = valueMobile,
                                maxLines: 1,
                                style: TextStyle(
                                  color: ColorValues.TEXT_COLOR,
                                  fontSize: 15.0,
                                  fontFamily: "customLight",

                                ),
                                decoration: InputDecoration(
                                  // fillColor: Colors.white, filled: true,
                                  border: InputBorder.none,
                                ),
                              ),
                              decoration: new BoxDecoration(

                                  border: new Border(

                                      bottom: new BorderSide(
                                        color: ColorValues.HINT_TEXT_COLOR,
                                      ))),
                            ))

                        ,
                      ),

                      new Container(
                          margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 0.0),
                          alignment: FractionalOffset(0.0, 0.5),
                          child: new Row(children: [
                            new Container(
                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                              child: new Image.asset('image/email.png'),
                              width: 15.0,
                              height: 15.0,

                              //    heig ht: 80.0,
                            ),
                            new Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 13.0,
                                color: ColorValues.HINT_TEXT_COLOR,
                                fontFamily: "customRegular",

                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],)
                      ),
                      new Container(
                        // height: 40.0,

                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                        child:                       new Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                              child: new TextFormField(
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                initialValue: email,
                                onSaved: (valueEmail) => email = valueEmail,
                                style: TextStyle(
                                  color: ColorValues.TEXT_COLOR,
                                  fontSize: 15.0,
                                  fontFamily: "customLight",

                                ),
                                decoration: InputDecoration(
                                  // fillColor: Colors.white, filled: true,
                                  border: InputBorder.none,


                                ),
                              ),
                              decoration: new BoxDecoration(

                                  border: new Border(

                                      bottom: new BorderSide(
                                        color: ColorValues.HINT_TEXT_COLOR,
                                      ))),
                            ))

                        ,
                      ),
/*
                      new Container(
                          margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 0.0),
                          alignment: FractionalOffset(0.0, 0.5),
                          child: new Row(children: [
                            new Container(
                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                              child: new Image.asset('image/shape.png'),
                              width: 15.0,
                              height: 15.0,

                              //    heig ht: 80.0,
                            ),
                            new Text(
                              "Address",
                              style: TextStyle(
                                fontSize: 13.0,
                                color: ColorValues.HINT_TEXT_COLOR,
                                fontFamily: "customRegular",

                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],)
                      ),
                      new Container(
                        // height: 40.0,

                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                        child:                       new Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                              child: new TextFormField(
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: TextStyle(
                                  color: ColorValues.TEXT_COLOR,
                                  fontSize: 15.0,
                                  fontFamily: "customLight",

                                ),
                                decoration: InputDecoration(
                                  // fillColor: Colors.white, filled: true,
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: ColorValues.HINT_TEXT_COLOR,
                                    fontSize: 15.0,
                                    fontFamily: "customLight",

                                  ),

                                  hintText: "1901 Thornridge Cir. Shiloh, Hawaii 81063",



                                ),
                              ),
                              decoration: new BoxDecoration(

                                  border: new Border(

                                      bottom: new BorderSide(
                                        color: ColorValues.HINT_TEXT_COLOR,
                                      ))),
                            )),
                      ),
                      new Container(
                          margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 0.0),
                          alignment: FractionalOffset(0.0, 0.5),
                          child: new Row(children: [
                            new Container(
                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                              child: new Image.asset('image/lock_on.png'),
                              width: 15.0,
                              height: 15.0,

                              //    heig ht: 80.0,
                            ),
                            new Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 13.0,
                                color: ColorValues.HINT_TEXT_COLOR,
                                fontFamily: "customRegular",

                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],)
                      ),
                      new Container(
                        // height: 40.0,

                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                        child:                       new Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                              child: new TextFormField(

                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: TextStyle(
                                  color: ColorValues.TEXT_COLOR,
                                  fontSize: 15.0,
                                  fontFamily: "customLight",

                                ),
                                decoration: InputDecoration(
                                  // fillColor: Colors.white, filled: true,
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: ColorValues.HINT_TEXT_COLOR,
                                    fontSize: 15.0,
                                    fontFamily: "customLight",
                                  ),
                                  hintText: "1234567",
                                ),
                              ),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                      bottom: new BorderSide(
                                        color: ColorValues.HINT_TEXT_COLOR,
                                      ))),
                            ),
                        ),
                      ),*/
                    ],
                  ),
                  ),
              ),
                  ],
                ),
            ),
            ),
          ),
          ),
        )
    );
  }
}