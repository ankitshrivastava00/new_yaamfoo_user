import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaamfoo/activity/OtpVerify.dart';
import 'package:yaamfoo/activity/login.dart';
import 'package:yaamfoo/comman/ApiConstant.dart';
import 'package:yaamfoo/comman/ToastWrap.dart';
import 'package:yaamfoo/constant/Constant.dart';
import 'package:yaamfoo/comman/CustomProgressLoader.dart';

import 'ForgotPassword.dart';
import 'package:yaamfoo/values/ColorValues.dart';
import 'StartScreen.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  int _counter = 0;
  bool obscureText = true, passwordVisible = false;
  String _name, _password,_mobile,_city,_email,_state,_deliveryAddress,_pincode;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String reply="";
  String _chosenValue;
  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }
  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _submitTask() async{
    try{



      final form = formKey.currentState;
      form.save();

      if(_name.isEmpty){
          Fluttertoast.showToast(
            msg:Constant.FIRST_NAME_VALIDATION,
            toastLength: Toast.LENGTH_SHORT,
           // gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            //  backgroundColor: Colors.red,
            //   textColor: Colors.white,
            //  fontSize: 16.0
          );
      }else  if(!_email.contains('@')){
          Fluttertoast.showToast(
            msg:Constant.EMAIL_VALIDATION,
            toastLength: Toast.LENGTH_SHORT,
           // gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            //  backgroundColor: Colors.red,
            //   textColor: Colors.white,
            //  fontSize: 16.0
          );
      }else  if(_mobile.isEmpty){
          Fluttertoast.showToast(
            msg:Constant.MOBILE_VALIDATION,
            toastLength: Toast.LENGTH_SHORT,
           // gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            //  backgroundColor: Colors.red,
            //   textColor: Colors.white,
            //  fontSize: 16.0
          );
      }else  if(_city.isEmpty){
          Fluttertoast.showToast(
            msg:Constant.CITY_VALIDATION,
            toastLength: Toast.LENGTH_SHORT,
           // gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            //  backgroundColor: Colors.red,
            //   textColor: Colors.white,
            //  fontSize: 16.0
          );
      }else  if(_state.isEmpty){
          Fluttertoast.showToast(
            msg:Constant.STATE_VALIDATION,
            toastLength: Toast.LENGTH_SHORT,
         //   gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            //  backgroundColor: Colors.red,
            //   textColor: Colors.white,
            //  fontSize: 16.0
          );
      }else  if(_deliveryAddress.isEmpty){
          Fluttertoast.showToast(
            msg:Constant.ADDRESS1_VALIDATION,
            toastLength: Toast.LENGTH_SHORT,
            //gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            //  backgroundColor: Colors.red,
            //   textColor: Colors.white,
            //  fontSize: 16.0
          );
      }else  if(_pincode.length!=6){
          Fluttertoast.showToast(
            msg:Constant.PINCODE_VALIDATION,
            toastLength: Toast.LENGTH_SHORT,
           // gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            //  backgroundColor: Colors.red,
            //   textColor: Colors.white,
            //  fontSize: 16.0
          );
      }else  if(_password.length < 6){
          Fluttertoast.showToast(
            msg:Constant.PASSWORD_VALIDATION,
            toastLength: Toast.LENGTH_SHORT,
          //  gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            //   backgroundColor: Colors.red,
            //   textColor: Colors.white,
            // fontSize: 1.0
          );

      }else{

        try {
          print("body+++++");
          CustomProgressLoader.showLoader(context);
          var url =Uri.parse(ApiConstant.SIGNUP_URL);
          Map<String, String> headers = {"Content-type": "application/json"};
          Map map = {
          "email":_email.toString(),
            "password":_password.toString(),
            "phone_number":_mobile,
            "first_name":_name,
            "last_name":_name,
            "user_type":"CUSTOMER"
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
            String id =data['user']['id'].toString();

            prefs.setString(Constant.USR_OTP, data['user']['otp'].toString());
            prefs.setString(Constant.USER_MOBILE, data['user']['phone_number'].toString());
            prefs.setString(Constant.USER_NAME, data['user']['first_name']);
            prefs.setString(Constant.USER_EMAIL, data['user']['email']);
            prefs.setString(Constant.USER_TOKEN, data['token']);
            prefs.setString(Constant.USER_ID, id);


            Fluttertoast.showToast(
              msg:Constant.USER_REGISTER,
              toastLength: Toast.LENGTH_SHORT,
              // gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              //  backgroundColor: Colors.red,
              //   textColor: Colors.white,
              //  fontSize: 16.0
            );
            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        OtpVerify()));

          } else {
            Fluttertoast.showToast(
              msg:Constant.USER_ALREADY,
              toastLength: Toast.LENGTH_SHORT,
              // gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              //  backgroundColor: Colors.red,
              //   textColor: Colors.white,
              //  fontSize: 16.0
            );
          //  ToastWrap.showSucess("User not registered", context);
            // ToastWrap.showSucess("Number Not Register. Please Sign Up", context);
          }
        } catch (e) {
          print("Error+++++" + e.toString());
          CustomProgressLoader.cancelLoader(context);

        }

      }

    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> _onWillPop() {
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) => StartScreen()));
  }

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    return new WillPopScope(
      // onWillPop: _onWillPop,
        child:
        new Scaffold(
          backgroundColor: Color(0xff00F9FF),
          key: scaffoldKey,


          body:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
          key: formKey,
          child:  SingleChildScrollView(
            child: Center(
              child: Container(
                //  color: Color(0xff00F9FF),
                child: Column(
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                      child: new Image.asset('image/toolbar_logo.png'),
                      width: 180.0,
                      //    height: 80.0,
                    ),

                    new Container(
                      margin: EdgeInsets.fromLTRB(20.0, 30.0, 0.0, 0.0),
                      alignment: FractionalOffset(0.0, 0.5),
                      child: new Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 25.0,
                          color: ColorValues.TEXT_COLOR,

                          fontFamily: "customRegular",
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),


                    new Container(
                      margin: EdgeInsets.fromLTRB(20.0, 30.0, 0.0, 0.0),
                      alignment: FractionalOffset(0.0, 0.5),
                      child: new Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: ColorValues.TEXT_COLOR,
                          fontFamily: "customLight",

                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    new Container(
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),

                  ),
                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child:new Center(
                      child: Container(

                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: new TextFormField(
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: TextStyle(
                                color: ColorValues.TEXT_COLOR,
                                fontSize: 15.0,
                                fontFamily: "customLight",

                              ),
                              onSaved: (valueName) => _name = valueName,

                              decoration: InputDecoration(
                                //fillColor: Colors.white, filled: true,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: ColorValues.HINT_TEXT_COLOR,
                                  fontSize: 15.0,
                                  fontFamily: "customLight",

                                ),

                                hintText: "Enter Here",

                                suffixIcon:    new Container(
                                  padding: EdgeInsets.all(11.0),
                                  child: new Image.asset('image/user.png'),
                                  width: 15.0,
                                  height: 15.0,
                                ),

                              ),
                            ),
                            decoration: new BoxDecoration(

                                border: new Border(

                                    bottom: new BorderSide(
                                        color: ColorValues.TEXT_COLOR,
                                        style: BorderStyle.none))),
                          ))

                      ,
                    ),




                    new Container(
                      margin: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                      alignment: FractionalOffset(0.0, 0.5),
                      child: new Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: ColorValues.TEXT_COLOR,
                          fontFamily: "customLight",
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    new Container(
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),

                  ),
                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child:new Center(
                      child: Container(

                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: new TextFormField(
                              style: TextStyle(
                                color: ColorValues.TEXT_COLOR,
                                fontSize: 15.0,
                                fontFamily: "customLight",

                              ),
                              onSaved: (valueEmail) => _email = valueEmail,
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              decoration: InputDecoration(
                                //fillColor: Colors.white, filled: true,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: ColorValues.HINT_TEXT_COLOR,
                                  fontSize: 15.0,
                                  fontFamily: "customLight",

                                ),

                                hintText: "john@gmail.com",

                                suffixIcon:    new Container(
                                  padding: EdgeInsets.all(14.0),
                                  child: new Image.asset('image/mail.png'),
                                  width: 15.0,
                                  height: 15.0,
                                ),

                              ),
                            ),
                            decoration: new BoxDecoration(

                                border: new Border(

                                    bottom: new BorderSide(
                                        color: ColorValues.TEXT_COLOR,
                                        style: BorderStyle.none))),
                          ))

                      ,
                    ),

                    new Container(
                      margin: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                      alignment: FractionalOffset(0.0, 0.5),
                      child: new Text(
                        "Phone",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: ColorValues.TEXT_COLOR,
                          fontFamily: "customLight",
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    new Container(
                      height: 45,
                      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),

                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(00),
                      ),
                      child:

                    Row(children: <Widget>[
                      new Expanded(
                      flex: 0,
                      child:
                      Container(
                        padding: EdgeInsets.only(bottom: 2.0),
                        margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(00),
                        ),
                        height:45,
                        child: DropdownButton<String>(
                          focusColor:Colors.white,
                          value: _chosenValue,
                          // elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor:ColorValues.TEXT_COLOR,
                          underline: Container(
                            height: 0,
                            color: Colors.deepPurpleAccent,
                          ),
                          items: <String>[
                            ' +91',
                            ' +92',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,style:TextStyle(color:ColorValues.TEXT_COLOR,fontFamily: 'customLight'),),
                            );
                          }).toList(),
                          hint:Text(
                            " +91",
                            style: TextStyle(
                                color: ColorValues.TEXT_COLOR,
                                fontSize: 14,
                                //fontWeight: FontWeight.w500,
                                fontFamily: 'customLight'
                            ),
                          ),
                          onChanged: (String value) {
                            setState(() {

                            });
                          },
                        ),

                      ),
                    ),
new Expanded(
flex: 0,
child:   new Container(
  height: 20.0,
  width: 0.5,
  color: ColorValues.TEXT_COLOR,
)
),
                      new Expanded(
                        flex: 1,
                        child:  new Container(
                       // width: 310,
                        height: 45.0,

                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                        child: Container(
                              //margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),

                          child: new TextFormField(
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: ColorValues.TEXT_COLOR,
                                  fontSize: 15.0,
                                  fontFamily: "customLight",

                                ),
                                maxLines: 1,
                            onSaved: (valueNumber) => _mobile = valueNumber,
                            keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: ColorValues.HINT_TEXT_COLOR,
                                    fontSize: 15.0,
                                    fontFamily: "customLight",

                                  ),
                                  hintText: "9999999999",

                                  suffixIcon:    new Container(
                                    padding: EdgeInsets.all(14.0),
                                    child: new Image.asset('image/call.png'),
                                    width: 15.0,
                                    height: 15.0,
                                  ),

                                ),
                              ),

                            ))

                        ,
                      ),
                    ],
                    ),

                    ),
                    new Container(
                      margin: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                      alignment: FractionalOffset(0.0, 0.5),
                      child: new Text(
                        "City",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: ColorValues.TEXT_COLOR,
                          fontFamily: "customLight",
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    new Container(
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),

                  ),
                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child:new Center(
                      child: Container(

                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: new TextFormField(
                              style: TextStyle(
                                color: ColorValues.TEXT_COLOR,
                                fontSize: 15.0,
                                fontFamily: "customLight",

                              ),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              onSaved: (valueCity) => _city = valueCity,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                //fillColor: Colors.white, filled: true,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: ColorValues.HINT_TEXT_COLOR,
                                  fontSize: 15.0,
                                  fontFamily: "customLight",

                                ),
                                hintText: "Madhya Pradesh",

                                suffixIcon:    new Container(
                                  padding: EdgeInsets.all(13.0),
                                  child: new Image.asset('image/shape.png'),
                                  width: 15.0,
                                  height: 15.0,
                                ),

                              ),
                            ),
                            decoration: new BoxDecoration(

                                border: new Border(

                                    bottom: new BorderSide(
                                        color: ColorValues.TEXT_COLOR,
                                        style: BorderStyle.none))),
                          ))

                      ,
                    ),


                    new Container(
                      margin: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                      alignment: FractionalOffset(0.0, 0.5),
                      child: new Text(
                        "State",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: ColorValues.TEXT_COLOR,
                          fontFamily: "customLight",
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    new Container(
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),

                  ),
                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child:new Center(
                      child: Container(

                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: new TextFormField(
                              style: TextStyle(
                                color: ColorValues.TEXT_COLOR,
                                fontSize: 15.0,
                                fontFamily: "customLight",

                              ),
                              onSaved: (valueState) => _state = valueState,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              decoration: InputDecoration(
                                //fillColor: Colors.white, filled: true,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: ColorValues.HINT_TEXT_COLOR,
                                  fontSize: 15.0,
                                  fontFamily: "customLight",

                                ),
                                hintText: "Madhya Pradesh",

                                suffixIcon:    new Container(
                                  padding: EdgeInsets.all(13.0),
                                  child: new Image.asset('image/shape.png'),
                                  width: 15.0,
                                  height: 15.0,
                                ),

                              ),
                            ),
                            decoration: new BoxDecoration(

                                border: new Border(

                                    bottom: new BorderSide(
                                        color: ColorValues.TEXT_COLOR,
                                        style: BorderStyle.none))),
                          ))

                      ,
                    ),

                    new Container(
                      margin: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                      alignment: FractionalOffset(0.0, 0.5),
                      child: new Text(
                        "Delivery Address",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: ColorValues.TEXT_COLOR,
                          fontFamily: "customLight",
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    new Container(
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),

                  ),
                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child:new Center(
                      child: Container(

                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: new TextFormField(
                              onSaved: (valueDeliverAddress) => _deliveryAddress = valueDeliverAddress,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.start,
                              maxLines: 1,
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
                                hintText: "1901 Thornridge Cir. Shiloh, Hawaii 81063",

                                suffixIcon:    new Container(
                                  padding: EdgeInsets.all(13.0),
                                  child: new Image.asset('image/shape.png'),
                                  width: 15.0,
                                  height: 15.0,
                                ),

                              ),
                            ),
                            decoration: new BoxDecoration(

                                border: new Border(

                                    bottom: new BorderSide(
                                        color: ColorValues.TEXT_COLOR,
                                        style: BorderStyle.none))),
                          ))

                      ,
                    ),

                    new Container(
                      margin: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                      alignment: FractionalOffset(0.0, 0.5),
                      child: new Text(
                        "Pincode",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: ColorValues.TEXT_COLOR,
                          fontFamily: "customLight",
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    new Container(
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),

                  ),
                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child:new Center(
                      child: Container(

                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: new TextFormField(
                              textAlign: TextAlign.start,
                              onSaved: (valuePincode) => _pincode = valuePincode,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
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
                                hintText: "452001",

                                suffixIcon:    new Container(
                                  padding: EdgeInsets.all(13.0),
                                  child: new Image.asset('image/shape.png'),
                                  width: 15.0,
                                  height: 15.0,
                                ),

                              ),
                            ),
                            decoration: new BoxDecoration(

                                border: new Border(

                                    bottom: new BorderSide(
                                        color: ColorValues.TEXT_COLOR,
                                        style: BorderStyle.none))),
                          ))

                      ,
                    ),

                    new Container(
                      margin: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                      alignment: FractionalOffset(0.0, 0.5),
                      child: new Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: ColorValues.TEXT_COLOR,
                          fontFamily: "customLight",
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    new Container(
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),

                  ),
                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child:new Center(
                      child: Container(

                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: new TextFormField(
                              textAlign: TextAlign.start,
                              obscureText: true,
                              style: TextStyle(
                                color: ColorValues.TEXT_COLOR,
                                fontSize: 15.0,
                                fontFamily: "customLight",

                              ),
                              maxLines: 1,
                              onSaved: (valuePassword) => _password = valuePassword,
                              decoration: InputDecoration(
                                //fillColor: Colors.white, filled: true,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: ColorValues.HINT_TEXT_COLOR,
                                  fontSize: 15.0,
                                  fontFamily: "customLight",

                                ),
                                hintText: "Password",

                                suffixIcon:    new Container(
                                  padding: EdgeInsets.all(13.0),
                                  child: new Image.asset('image/lock.png'),
                                  width: 15.0,
                                  height: 15.0,
                                ),

                              ),
                            ),
                            decoration: new BoxDecoration(

                                border: new Border(

                                    bottom: new BorderSide(
                                        color: ColorValues.TEXT_COLOR,
                                        style: BorderStyle.none))),
                          ))

                      ,
                    ),

                    new Container(
                      height: 40,
                      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                      child: new Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(5.0),
                        color: ColorValues.TEXT_COLOR,
                        child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                            onPressed: () {
                              _submitTask();
                            },
                            child: Text(
                              "Signup",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,fontSize: 15.0,
                                fontFamily: "customRegular",
                              ),
                            )),
                      ),
                    ),


                    new Container(
                      margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
                      child:
                      new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [

                          new Container(


                            child:
                            new Text(
                              "Already Create an Account, ",
                              style: TextStyle(
                                fontSize: 13.0,
                                color: ColorValues.TEXT_COLOR,

                                fontFamily: "customLight",

                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),

                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) => Login()));
                            },
                            child:  new Text(
                              " Sign In",
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: ColorValues.TEXT_COLOR,
                                  fontFamily: "customLight",
                                  fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.left,

                            ),
                          ),

                        ],
                      ),

                    ),

                  ],
                ),
              ),
            ),
          ),
          ),
          ),
        )
    );
  }
}