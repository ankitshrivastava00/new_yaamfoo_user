import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yaamfoo/activity/login.dart';
import 'package:yaamfoo/comman/ApiConstant.dart';
import 'package:yaamfoo/comman/CustomProgressLoader.dart';
import 'package:yaamfoo/constant/Constant.dart';
import 'package:yaamfoo/drawer/tabs/tabspage.dart';
import 'package:yaamfoo/values/ColorValues.dart';

class CreateNewPassword extends StatefulWidget {
  String otp,mobile;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  CreateNewPasswordState createState() => CreateNewPasswordState();

}

class CreateNewPasswordState extends State<CreateNewPassword> {
  int _counter = 0;
  SharedPreferences prefs;

  String reply;
  String _mobile, _password,_newPassword;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _mobile= prefs.getString(Constant.USER_MOBILE.toString());

    });
  }
  void _submitTask() async{
    try{



      final form = formKey.currentState;
      form.save();

      if(_newPassword.length<6){
        setState(() {
          Fluttertoast.showToast(
            msg:Constant.PASSWORD_VALIDATION,
            toastLength: Toast.LENGTH_SHORT,
            //    gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            //  backgroundColor: Colors.red,
            //   textColor: Colors.white,
            //  fontSize: 16.0
          );
        });
      }else /*if(_password.length<6){
        setState(() {
          Fluttertoast.showToast(
            msg:Constant.PASSWORD_VALIDATION,
            toastLength: Toast.LENGTH_SHORT,
            // gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            //   backgroundColor: Colors.red,
            //   textColor: Colors.white,
            // fontSize: 1.0
          );
        });

      }else*/ if(_password!=_newPassword){
        setState(() {
          Fluttertoast.showToast(
            msg:Constant.CONFIRM_PASSWORD_VALIDATION,
            toastLength: Toast.LENGTH_SHORT,
            // gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            //   backgroundColor: Colors.red,
            //   textColor: Colors.white,
            // fontSize: 1.0
          );
        });

      }else{

        try {
          print("body+++++");
          CustomProgressLoader.showLoader(context);
          var url =Uri.parse(ApiConstant.FORGOT_URL);
          Map<String, String> headers = {"Content-type": "application/json"};
          Map map = {
              "phone_number":_mobile,
              "password":_newPassword
            

          };
          // make POST request
          Response response =
          await post(url, headers: headers, body: json.encode(map));
          // check the status code for the result
          // this API passes back the id of the new item added to the body
          String body = response.body;
          CustomProgressLoader.cancelLoader(context);
          var data = json.decode(body);
          if (data["status"].toString() == "201") {

            Fluttertoast.showToast(
              msg:'Change Successful',
              toastLength: Toast.LENGTH_SHORT,
              //    gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              //  backgroundColor: Colors.red,
              //   textColor: Colors.white,
              //  fontSize: 16.0
            );
            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Login()));

          } else {
            Fluttertoast.showToast(
              msg:Constant.SERVER_ISSUE,
              toastLength: Toast.LENGTH_SHORT,
              //    gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              //  backgroundColor: Colors.red,
              //   textColor: Colors.white,
              //  fontSize: 16.0
            );
            //ToastWrap.showSucess("User not registered", context);
            // ToastWrap.showSucess("Number Not Register. Please Sign Up", context);
          }
          print("body+++++" + body.toString());
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

    return new Scaffold(
      backgroundColor: Color(0xff00F9FF),

      key: scaffoldKey,
      /*appBar: AppBar(
        title: new Text(""),
        backgroundColor: Colors.blue,
      ),*/
      body:  Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                  child: new Image.asset('image/reset_password.png'),
                  width: 150.0,
                  height: 150.0,
                ),

                new Container(
                  margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                  child: new Text("Create New Password", style: TextStyle(
                    fontSize: 16.0,
                    color: ColorValues.TEXT_COLOR,
                    fontWeight: FontWeight.bold,
                    fontFamily: "customLight",

                  ),
                    textAlign: TextAlign.center,
                  ),
                ),
                new Container(
                  margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: new Text("Your new password must be different from previous used password", style: TextStyle(
                    fontSize: 14.0,
                    color: ColorValues.TEXT_COLOR,
                    fontFamily: "customLight",

                  ),
                    textAlign: TextAlign.center,
                  ),
                ),
          new Container(
           // height: 45.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),

            ),
            margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
            child:new Center(
              child: Container(

                padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  child: TextFormField(
                    onSaved: (valueMobile) => _newPassword = valueMobile,

                    obscureText:true,
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
                      hintText: "New Password",
                    ),
                ),
                ),
                ),
                ),
          new Container(
          //  height: 45.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),

            ),
            margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
            child:new Center(
              child: Container(

                padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  child: TextFormField(
                    onSaved: (valuePassword) => _password = valuePassword,

                    obscureText:true,
                    style: TextStyle(
                      color: ColorValues.TEXT_COLOR,
                      fontSize: 15.0,
                      fontFamily: "customLight",

                    ),
                    decoration: InputDecoration(
                      //fillColor: Colors.white, filled: true,
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: ColorValues.HINT_TEXT_COLOR,
                        fontSize: 15.0,
                        fontFamily: "customLight",

                      ),
                      hintText: "Confirm Password",

                    ),


                  )
                  )
                  )
                  ,
                ),
                new Container(
                  height: 40,

                  margin: EdgeInsets.fromLTRB(100.0, 30.0, 100.0, 0.0),
                  child: new Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(5.0),
                    color: ColorValues.TEXT_COLOR,
                    child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                        onPressed: () {
                          _submitTask();
                          },
                        child: Text(
                          "Reset Password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                            fontFamily: "customRegular",

                             ),
                        )),
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