import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaamfoo/activity/CreateNewPassword.dart';
import 'package:yaamfoo/constant/Constant.dart';
import 'package:yaamfoo/drawer/tabs/tabspage.dart';
import 'package:yaamfoo/values/ColorValues.dart';
import 'package:yaamfoo/comman/ApiConstant.dart';
import 'package:yaamfoo/comman/ToastWrap.dart';
import 'package:yaamfoo/constant/Constant.dart';
import 'package:yaamfoo/comman/CustomProgressLoader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class OtpVerify extends StatefulWidget {
  String type;
OtpVerify({this.type});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  OtpVerifyState createState() => OtpVerifyState();
}

class OtpVerifyState extends State<OtpVerify> {
  int _counter = 0;
  TextEditingController mobile = new TextEditingController();
  String reply,_mobile,_otp;
  SharedPreferences prefs;
  var onTapRecognizer;
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  String currentText = "";
  void _submitTask() async{
    try{



      if(_otp!=currentText){
        Fluttertoast.showToast(
          msg:Constant.OTP_VALIDATION,
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
          var url =Uri.parse(ApiConstant.OTP_VERIFY);
          Map<String, String> headers = {"Content-type": "application/json"};
          Map map = {

            "phone_number":_mobile,
            "otp":_otp

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

            prefs.setString(Constant.LOGIN_STATUS, "true");
  if(widget.type=="change"){
    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                CreateNewPassword()));
  }else{
    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                TabsPage(selectedIndex: 0,)));
  }


          } else {
            Fluttertoast.showToast(
              msg:Constant.INVALID_OTP,
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

  void _resendOtp() async{

        try {
          print("body+++++");
          CustomProgressLoader.showLoader(context);
          var url =Uri.parse(ApiConstant.OTP_LOGIN);
          Map<String, String> headers = {"Content-type": "application/json"};
          Map map = {
            "phone_number":_mobile
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

            prefs.setString(Constant.USR_OTP, data['user']['otp'].toString());

            Fluttertoast.showToast(
              msg:Constant.NOTIFICATION_SEND,
              toastLength: Toast.LENGTH_SHORT,
              // gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              //  backgroundColor: Colors.red,
              //   textColor: Colors.white,
              //  fontSize: 16.0
            );

          } else {
            Fluttertoast.showToast(
              msg:Constant.SERVER_ISSUE,
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

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _mobile= prefs.getString(Constant.USER_MOBILE.toString());
      _otp= prefs.getString(Constant.USR_OTP.toString());

    });
  }
  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: Color(0xff00F9FF),

      /*appBar: AppBar(
        title: new Text(""),
        backgroundColor: Colors.blue,
      ),*/
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                new Container(
                  padding:EdgeInsets.all(10.0),

                  margin: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                  child: new Image.asset('image/otp.png'),
                  width: 120.0,
                  height: 120.0,
                ),

                new Container(
                  margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                  child: new Text("OTP Verification", style: TextStyle(
                    fontSize: 19.0,
                    color: ColorValues.TEXT_COLOR,
                    fontFamily: "customLight",
                    fontWeight: FontWeight.bold
                  ),
                    textAlign: TextAlign.center,
                  ),
                ),
                new Container(
                  margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: new Text("Enter OTP Code send to ${_otp }", style: TextStyle(
                    fontSize: 14.0,
                    color: ColorValues.TEXT_COLOR,
                    fontFamily: "customLight",

                  ),
                    textAlign: TextAlign.center,
                  ),
                ),
                new Container(
                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child: new Text("+91 ${_mobile}", style: TextStyle(
                    fontSize: 14.0,
                    color: ColorValues.TEXT_COLOR,
                    fontFamily: "customLight",
                  ),
                    textAlign: TextAlign.center,
                  ),
                ),
          Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 30.0, horizontal: 30),
              child: PinCodeTextField(
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: "customLight",
                ),
                length: 6,
                obscureText: false,
                obscuringCharacter: '*',
               // animationType: AnimationType.fade,
                validator: (v) {
                 /* if (v.length < 3) {
                    return "I'm from validator";
                  } else {
                    return null;
                  }*/
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 40,
                  fieldWidth: 40,
                  inactiveFillColor: Colors.white,
                  borderWidth: 0.0,
                 // disabledColor: Colors.white,
                 // inactiveColor: Colors.white,
                  activeFillColor:
                  hasError ? Colors.white : Colors.white,
                ),
                cursorColor: Colors.black,
                animationDuration: Duration(milliseconds: 300),
                textStyle: TextStyle(fontSize: 12, height: 1.6,
                  fontFamily: "customLight",

                ),
                backgroundColor: Color(0xff00F9FF),
                enableActiveFill: true,
                errorAnimationController: errorController,
                controller: textEditingController,
                keyboardType: TextInputType.number,
                boxShadows: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                onCompleted: (v) {
                  print("Completed");
                },
                // onTap: () {
                //   print("Pressed");
                // },
                onChanged: (value) {
                  print(value);
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              )),

        new Container(
                  margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                  child: new Text("Don’t Receive OTP Code?", style: TextStyle(
                    fontSize: 14.0,
                    color: ColorValues.TEXT_COLOR,
                    fontFamily: "customLight",
                  ),
                    textAlign: TextAlign.center,
                  ),
                ),
                new GestureDetector(
                  child:
                new Container(
                  margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: ColorValues.TEXT_COLOR,),
                    ),),
                  child: new Text("Resend code", style: TextStyle(
                    fontSize: 14.0,
                    color: ColorValues.TEXT_COLOR,
                    fontFamily: "customLight",
                    fontWeight: FontWeight.bold

                  ),
                    textAlign: TextAlign.center,
                  ),
                ),
                  onTap: (){
                    _resendOtp();
                  },
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
                          "Verify",
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
    );
  }
}