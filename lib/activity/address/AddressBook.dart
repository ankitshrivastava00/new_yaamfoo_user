import  'dart:async';
import 'dart:convert' show json;
import 'dart:convert';

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaamfoo/Model/AddressListModel.dart';
import 'package:yaamfoo/Model/Dbmodel.dart';
import 'package:yaamfoo/Model/ProductModel.dart';
import 'package:yaamfoo/activity/address/AddAddress.dart';
import 'package:yaamfoo/comman/ApiConstant.dart';
import 'package:yaamfoo/constant/Constant.dart';
import 'package:yaamfoo/database/DBProvider.dart';
import 'package:yaamfoo/values/ColorValues.dart';

import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
class AddressBook extends StatefulWidget {
  String type = "";

  Msg _mData;
  SharedPreferences prefs;

  //MyCart(this.type, this._mData);

  static final String route = "Cart-route";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddressBookState();
  }
}

class AddressBookState extends State<AddressBook> {
  String type = "";
  var isLoading= false;
  SharedPreferences prefs;
  List<Dbmodel> cart = [];
  List<Address> addressList= new List();
  AddressListModel _addressListModel;
  String _name,_email,userId;

  productApi(id) async {
    // set up POST request arguments
    setState(() {
      isLoading=true;

    });

    try {
      print("body+++++");
      //  CustomProgressLoader.showLoader(context);
      var url =Uri.parse(ApiConstant.ADDRESS_BOOK+id);
      Map<String, String> headers = {"Content-type": "application/json"};

      Response response = await get(url, headers: headers);
      // check the status code for the result
      int statusCode = response.statusCode;
      // this API passes back the id of the new item added to the body
      String body = response.body;
      print("response+++" + body);
      // CustomProgressLoader.cancelLoader(context);
      if (response.statusCode == 200) {

        addressList = [];
        _addressListModel = AddressListModel.fromJson(json.decode(body));


        setState(() {
          addressList.addAll(_addressListModel.data.address);

          isLoading=false;

        });
      }
      print("body+++++" + body.toString());
    } catch (e) {
      print("Error+++++" + e.toString());
    }
  }

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
      productApi(prefs.getString(Constant.USER_ID));
      userId=prefs.getString(Constant.USER_ID);
      _email=prefs.getString(Constant.USER_EMAIL);
      _name=prefs.getString(Constant.USER_NAME);

    });
  }

  @override
  Widget build(BuildContext context) {
    Constant.applicationContext = context;

      return /*WillPopScope(
        onWillPop: () {
         Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        AddressBook()));

          *//*  if (widget.type == "home") {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new DashBoardWidget()));
          } else if (widget.type == "homeviewall") {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new HomeViewAll()));
          } else if (widget.type == "product") {
            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new ProductDetailPage(widget._mData, "backfromcart")));
          } else {*//*
          Navigator.pop(context);
          //  }
        },
        child:*/ Scaffold(
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
           /*   onTap: () {
                *//* if (widget.type == "home") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new DashBoardWidget()));
                } else if (widget.type == "homeviewall") {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new HomeViewAll()));
                } else if (widget.type == "product") {
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                        //   builder: (context) => new DashBoardWidget()));
                          builder: (context) => new ProductDetailPage(
                              widget._mData, "backfromcart")));
                } else {*//*
                Navigator.pop(context);
                //  }
              },*/
            ),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Location',
              style: new TextStyle(
                  color: ColorValues.TEXT_COLOR,
                  fontWeight: FontWeight.w600,
                  fontFamily: "customRegular",
                  fontSize: 18.0),
            ),
          ),
          body: new Padding(padding: EdgeInsets.all(2.0),
          child:  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.48,
                        child: ListView.builder(
                          itemCount:addressList.length,
                          itemBuilder: (BuildContext context, int index) {
                            // Dbmodel item = snapshot.data[index];
                            return new GestureDetector(
                              child: Card(
                                child:
                                Container(
                                  padding: EdgeInsets.all(5.0),

                                  margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                                child:new Column(
                                  children: [

                                  new Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Expanded(
                                        child: new Container(
                                            height: 25.0,
                                            width: 25.0,
                                            padding: EdgeInsets.all(5.0),
                                            margin: const EdgeInsets.fromLTRB(
                                                5.0, 0.0, 5.0, 0.0),


                                            decoration: new BoxDecoration(
                                              image: new DecorationImage(
                                                image: new ExactAssetImage('image/circle_red.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            // color: Colors.transparent,

                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(0.0),
                                              child:
                                              Image.asset(
                                                'image/shape.png',
                                                height: 20.0,
                                                width: 20.0,
                                                color: ColorValues.LOGOUT_TEXT,
                                              ),

                                            )),
                                        flex: 0,
                                      ),
                                      new Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10.0, 0, 0, 0),
                                          child:  new Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0.0, 0, 0, 5.0),
                                            //  height: 120.0,
                                            //  width: 100.0,
                                            child:new Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,

                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                new Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0.0, 0, 0, 5.0),
                                                  //  height: 120.0,
                                                  //  width: 100.0,
                                                  child:
                                                  new Text(
                                                    addressList[index].address1,
                                                    style: new TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 12.0,
                                                        color: ColorValues.TEXT_COLOR,
                                                        fontFamily:
                                                        "customRegular"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        flex: 1,
                                      ),

                                    ],
                                  ),
                                 
                                ],),

                              ),
                              ),

                            );
                          },
                        ),
                      ),
                    ),
                    new Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5.0, 0, 5.0, 10),
                          child:                     new Container(
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
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => AddAddress()));
                                  },
                                  child: Text(
                                    "Add Address",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ColorValues.BACKGROUND,
                                      fontSize: 14.0,
                                      fontFamily: "customRegular",
                                    ),
                                  )),
                            ),
                          ),


                        )),

                  ],
                            )
                ),




      );

}
}
