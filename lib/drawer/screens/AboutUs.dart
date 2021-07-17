import 'dart:async';
import 'dart:convert' show json;
import 'dart:convert';

//import 'package:razorpay_plugin/razorpay_plugin.dart';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaamfoo/Model/Dbmodel.dart';
import 'package:yaamfoo/Model/ProductModel.dart';
import 'package:yaamfoo/Model/favoriteModel.dart';
import 'package:yaamfoo/activity/ThankYou.dart';
import 'package:yaamfoo/comman/ApiConstant.dart';
import 'package:yaamfoo/comman/CustomProgressLoader.dart';
import 'package:yaamfoo/constant/Padding_Wrap.dart';
import 'package:yaamfoo/constant/Constant.dart';
import 'package:yaamfoo/database/DBProvider.dart';
import 'package:yaamfoo/values/ColorValues.dart';

import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

class AboutUs extends StatefulWidget {
  String type = "";
  AboutUs({Key key, this.type}) : super(key: key);

  Msg _mData;
  SharedPreferences prefs;

  //MyCart(this.type, this._mData);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AboutUsState();
  }
}

class AboutUsState extends State<AboutUs> {
  String type = "";
  var isLoading= false;
  SharedPreferences prefs;
  List<Favorite> favoriteList= new List();
  favoriteModel _homeModel;
  productApi(id) async {
    // set up POST request arguments
    setState(() {
      isLoading=true;

    });

    try {
      print("body+++++");
      //  CustomProgressLoader.showLoader(context);
      var url =Uri.parse(ApiConstant.FAVORITE_LIST+id);
      Map<String, String> headers = {"Content-type": "application/json"};

      Response response = await get(url, headers: headers);
      // check the status code for the result
      int statusCode = response.statusCode;
      // this API passes back the id of the new item added to the body
      String body = response.body;
      print("response+++" + body);
      // CustomProgressLoader.cancelLoader(context);
      if (response.statusCode == 200) {

        favoriteList = [];
        _homeModel = favoriteModel.fromJson(json.decode(body));


        setState(() {

          favoriteList.addAll(_homeModel.data.favorite);
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



  }
  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    productApi(prefs.getString(Constant.USER_ID));
  }

  @override
  Widget build(BuildContext context) {
    Constant.applicationContext = context;
      return  Scaffold(
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
Navigator.pop(context);              },
            ),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'About Us',
              style: new TextStyle(
                  color: ColorValues.TEXT_COLOR,
                  fontWeight: FontWeight.w600,
                  fontFamily: "customRegular",
                  fontSize: 18.0),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(15.0),
            child: Text('Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
              style: new TextStyle(
                  color: ColorValues.TEXT_COLOR,
                  fontFamily: "customLight",
                  fontSize: 15.0,
              ),
              textAlign: TextAlign.justify,
            ),  
          ),
      );
    }

}
