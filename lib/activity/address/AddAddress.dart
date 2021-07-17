import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaamfoo/activity/address/AddressBook.dart';
import 'package:yaamfoo/activity/login.dart';
import 'package:yaamfoo/comman/ApiConstant.dart';
import 'package:yaamfoo/comman/CustomProgressLoader.dart';
import 'package:yaamfoo/constant/Constant.dart';
import 'package:yaamfoo/constant/Padding_Wrap.dart';
import 'package:http/http.dart';
import 'package:yaamfoo/values/ColorValues.dart';

class AddAddress extends StatefulWidget {
  AddAddress({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  AddAddressState createState() => AddAddressState();
}

class AddAddressState extends State<AddAddress> {
  int _counter = 0;
  bool obscureText = true, passwordVisible = false;

  TextEditingController em = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  String reply="";
  String _city,state,address1,address2='',_pincode;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String userId,_name,_email,_mobile;
  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();

    /*if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) => productApi(USER_ID));
    }*/

  }
  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userId=prefs.getString(Constant.USER_ID);
      _email=prefs.getString(Constant.USER_EMAIL);
      _name=prefs.getString(Constant.USER_NAME);

    });
  }
  void _submitTask() async{
    try{
      final form = formKey.currentState;
      form.save();

       if(state.isEmpty){
        Fluttertoast.showToast(
          msg:Constant.STATE_VALIDATION,
          toastLength: Toast.LENGTH_SHORT,
          //gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          //  backgroundColor: Colors.red,
          //   textColor: Colors.white,
          //  fontSize: 16.0
        );
      }else     if(_city.isEmpty){
        Fluttertoast.showToast(
          msg:Constant.CITY_VALIDATION,
          toastLength: Toast.LENGTH_SHORT,
          //gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          //  backgroundColor: Colors.red,
          //   textColor: Colors.white,
          //  fontSize: 16.0
        );
      }else     if(address1.isEmpty){
        Fluttertoast.showToast(
          msg:Constant.ADDRESS1_VALIDATION,
          toastLength: Toast.LENGTH_SHORT,
          //gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          //  backgroundColor: Colors.red,
          //   textColor: Colors.white,
          //  fontSize: 16.0
        );
      }else if(_pincode.length!=6){
        Fluttertoast.showToast(
          msg:Constant.PINCODE_VALIDATION,
          toastLength: Toast.LENGTH_SHORT,
          //gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          //  backgroundColor: Colors.red,
          //   textColor: Colors.white,
          //  fontSize: 16.0
        );
      }else  {

        try {
          print("body+++++");
          CustomProgressLoader.showLoader(context);
          var url =Uri.parse(ApiConstant.ADD_ADDRESS);
          Map<String, String> headers = {"Content-type": "application/json"};
          Map map = {
            "user":userId,
            "city":_city,
            "state":state,
            "address1":address1,
            "address2":address2,
            "postal_code":_pincode
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
              msg:Constant.ADD_SUCCESFULLY,
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
                        AddressBook()));

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

    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AddressBook()));
    },
    child:
        new Scaffold(
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
                            AddressBook()));
              },
            ),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Address',
              style: new TextStyle(
                  color: ColorValues.TEXT_COLOR,
                  fontWeight: FontWeight.w600,
                  fontFamily: "customRegular",
                  fontSize: 18.0),
            ),
          ),

          body: Form(
    key: formKey,
    child: SingleChildScrollView(
            child: Center(
              child: Container(
                //  color: Color(0xff00F9FF),
                child: Column(
                  children: <Widget>[

                    new Container(
                      //  height: 45.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),

                      ),
                      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                      child:
                      new Center(
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
                              decoration: InputDecoration(
                                icon:
                                new Container(
                                 // padding: EdgeInsets.all(11.0),
                                  child: new Image.asset('image/search_icon.png'),
                                  width: 20.0,
                                  height: 20.0,
                                ),
                                //  fillColor: Colors.white, filled: true,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: ColorValues.HINT_TEXT_COLOR,
                                  fontSize: 15.0,
                                  fontFamily: "customLight",

                                ),

                                hintText: "Search.....",


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

                    PaddingWrap.paddingfromLTRB(
                        20.0,
                        20.0,
                        0.0,
                        0.0,
                        new InkWell(
                            child:
                            new Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 0,
                                  child:  Image.asset(
                                    'image/shape.png',
                                    height: 15.0,
                                    width: 15.0,
                                    color: ColorValues.LOGOUT_TEXT,
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child:new Padding(
                                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                    child: new Text(
                                      "Use Current Location",
                                      style: TextStyle(
                                          fontFamily: 'customRegular',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.0,
                                        color: ColorValues.LOGOUT_TEXT,
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            onTap: () {
                            }
                        )
                    ),


/*


                    new Container(
                      margin: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                      alignment: FractionalOffset(0.0, 0.5),
                      child: new Text(
                        "House Name",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: ColorValues.TEXT_COLOR,
                          fontFamily: "customLight",
                        ),
                        textAlign: TextAlign.left,
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
                            child: new TextFormField(
                              style: TextStyle(
                                color: ColorValues.TEXT_COLOR,
                                fontSize: 15.0,
                                fontFamily: "customLight",

                              ),

                              textAlign: TextAlign.start,
                              maxLines: 1,
                              decoration: InputDecoration(
                              //  fillColor: Colors.white, filled: true,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: ColorValues.HINT_TEXT_COLOR,
                                  fontSize: 15.0,
                                  fontFamily: "customLight",

                                ),

                                hintText: "House Name",


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
                        "Landmark",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: ColorValues.TEXT_COLOR,
                          fontFamily: "customLight",
                        ),
                        textAlign: TextAlign.left,
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
                            child: new TextFormField(
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: ColorValues.TEXT_COLOR,
                                fontSize: 15.0,
                                fontFamily: "customLight",

                              ),
                              maxLines: 1,
                              decoration: InputDecoration(
                             //   fillColor: Colors.white, filled: true,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: ColorValues.HINT_TEXT_COLOR,
                                  fontSize: 15.0,
                                  fontFamily: "customLight",

                                ),
                                hintText: "Landmark",



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
*/

                    new Container(
                      margin: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
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
                            child: new TextFormField(
                              onSaved: (valueState) => state = valueState,

                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: TextStyle(
                                color: ColorValues.TEXT_COLOR,
                                fontSize: 15.0,
                                fontFamily: "customLight",

                              ),
                              decoration: InputDecoration(
                                //  fillColor: Colors.white, filled: true,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: ColorValues.HINT_TEXT_COLOR,
                                  fontSize: 15.0,
                                  fontFamily: "customLight",

                                ),

                                hintText: "",



                              ),
                            ),

                          ))

                      ,
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
                            child: new TextFormField(
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: TextStyle(
                                color: ColorValues.TEXT_COLOR,
                                fontSize: 15.0,
                                fontFamily: "customLight",

                              ),
                              onSaved: (valueCity) => _city = valueCity,

                              decoration: InputDecoration(
                            //    fillColor: Colors.white, filled: true,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: ColorValues.HINT_TEXT_COLOR,
                                  fontSize: 15.0,
                                  fontFamily: "customLight",

                                ),
                                hintText: "",


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
                        "Address",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: ColorValues.TEXT_COLOR,
                          fontFamily: "customLight",
                        ),
                        textAlign: TextAlign.left,
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
                            child: new TextFormField(
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: TextStyle(
                                color: ColorValues.TEXT_COLOR,
                                fontSize: 15.0,
                                fontFamily: "customLight",

                              ),
                              onSaved: (valueAddress) => address1 = valueAddress,

                              decoration: InputDecoration(
                            //    fillColor: Colors.white, filled: true,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: ColorValues.HINT_TEXT_COLOR,
                                  fontSize: 15.0,
                                  fontFamily: "customLight",

                                ),
                                hintText: "",


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
                            child: new TextFormField(
                              onSaved: (valuePincode) => _pincode = valuePincode,

                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: TextStyle(
                                color: ColorValues.TEXT_COLOR,
                                fontSize: 15.0,
                                fontFamily: "customLight",

                              ),
                              keyboardType: TextInputType.phone,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(6),

                              ],
                              decoration: InputDecoration(
                                //fillColor: Colors.white, filled: true,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: ColorValues.HINT_TEXT_COLOR,
                                  fontSize: 15.0,
                                  fontFamily: "customLight",

                                ),
                                hintText: "",


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
                      margin: EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 20.0),
                      child: new Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(50.0),
                        color: ColorValues.TEXT_COLOR,
                        child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                            onPressed: () {
                              _submitTask();
                            },
                            child: Text(
                              "Save",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorValues.BACKGROUND,
                                fontSize: 14.0,
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
        )
    );
  }
}