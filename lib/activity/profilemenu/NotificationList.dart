import 'dart:async';
import 'dart:convert' show json;
import 'dart:convert';
import 'dart:io';

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaamfoo/Model/Dbmodel.dart';
import 'package:yaamfoo/Model/ProductModel.dart';
import 'package:yaamfoo/Model/notificationModel.dart';
import 'package:yaamfoo/comman/ApiConstant.dart';
import 'package:yaamfoo/constant/Constant.dart';
import 'package:yaamfoo/database/DBProvider.dart';
import 'package:yaamfoo/values/ColorValues.dart';

class NotificationList extends StatefulWidget {

  String type = "";
  Msg _mData;
  SharedPreferences prefs;
  static final String route = "Cart-route";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NotificationListState();
  }
}

class NotificationListState extends State<NotificationList> {
  String type = "";
  var isLoading= false;
  var isdata= false;

  SharedPreferences prefs;
  List<Dbmodel> cart = [];
  List<notificationmodel> lis = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();

    setState(() {});

    notification(ApiConstant.NOTIFICATION_LIST);


  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<String> notification(String url) async {
    try {
      setState(() {
        isLoading = true;
        isdata=true;
      });
      //prefs = await SharedPreferences.getInstance();
      // var isConnect = await ConnectionDetector.isConnected();
      //  if (isConnect) {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      //request.add(utf8.encode(json.encode(jsonMap)));
      HttpClientResponse response = await request.close();
      // todo - you should check the response.statusCode
      var reply = await response.transform(utf8.decoder).join();
      httpClient.close();
      Map data = json.decode(reply);
      String status = data['status'].toString();

      if (status == "201") {
        for (var word in data['data']['notification']) {
          String id = word["id"].toString();
          String status = word["status"].toString();
          String created = word["created_at"].toString();
          String updated = word["updated_at"].toString();
          String note = word["note"].toString();
          String title = word["title"].toString();

          setState(() {
            lis.add(notificationmodel(id,status,created,updated,title,note));
            isdata = false;

          });
        }
      } else {
        /*setState(() {
          isdata = false;
        });*/
      }
      setState(() {
        isLoading = false;
      });
      print('RESPONCE_DATA : ' + status);
    }

    catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0);
    }
  }


  @override
  Widget build(BuildContext context) {
    Constant.applicationContext = context;

    if (!isdata) {
      return WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          //  }
        },
        child: Scaffold(
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
                Navigator.pop(context);

              },
            ),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Notification',
              style: new TextStyle(
                  color: ColorValues.TEXT_COLOR,
                  fontWeight: FontWeight.w600,
                  fontFamily: "customRegular",
                  fontSize: 18.0),
            ),
          ),
          body: FutureBuilder<List<Dbmodel>>(
            future: DBProvider.db.getAllClients(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Dbmodel>> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          margin: const EdgeInsets.fromLTRB(
                              10.0, 10, 10.0, 10.0),
                          //  height: 120.0,
                          //  width: 100.0,
                          child:
                          new Text("Recent"
                            /*item.weight
                                                    .replaceAll(".00", "") +
                                                    " " +
                                                    item.unit*/,
                            style: new TextStyle(
                                fontSize: 12.0,
                                color: ColorValues.TEXT_COLOR,
fontWeight: FontWeight.w500,
                                fontFamily:
                                "customRegular"),
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.fromLTRB(
                              10.0, 10, 10.0, 10.0),
                          //  height: 120.0,
                          //  width: 100.0,
                          child:
                          new Text("Clear All"
                            /*item.weight
                                                    .replaceAll(".00", "") +
                                                    " " +
                                                    item.unit*/,
                            style: new TextStyle(
                                fontSize: 12.0,
                                color: ColorValues.TEXT_COLOR,
                                fontWeight: FontWeight.w500,

                                fontFamily:
                                "customRegular"),
                          ),
                        ),

                      ],
                    ),
                    new Container(
                      height: 0.5,
                      color: ColorValues.TIME_NOTITFICAITON,

                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.48,
                        child: ListView.builder(
                          itemCount: lis.length,
                          itemBuilder: (BuildContext context, int index) {
                            // Dbmodel item = snapshot.data[index];
                            return new GestureDetector(
                              child:
                              Container(
                                margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                                child:new Column(
                                  children: [
                                  new Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Expanded(
                                        child: new Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                5.0, 0.0, 5.0, 0.0),
                                          // color: Colors.transparent,
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(0.0),
                                              child:
                                              Image.asset(
                                                'image/notification_icon.png',
                                                height: 40.0,
                                                width: 40.0,
                                              ),
                                              /*new CachedNetworkImage(

                                                imageUrl:"https://toppng.com/uploads/preview/burger-11528340630dx5paxa77f.png"
                                                *//*profileInfoModal != null
                          ?*//*
                                               *//* Constant.CONSTANT_IMAGE_PATH +
                                                    item.defaultImage*//*
                                                *//*: ""*//*,
                                                fit: BoxFit.cover,

                                              ),*/
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
                                                      0.0, 5, 0, 5.0),
                                                  //  height: 120.0,
                                                  //  width: 100.0,
                                                  child:
                                                  new Text(
                                                    lis[index].title,
/*
                                                    'Lorem ipsum dolor sit amet, consectetur adip isc ing elit. Arcu nibh venenatis.',
*/
                                                    style: new TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 14.0,
                                                        color: ColorValues.TEXT_COLOR,
                                                        fontFamily:
                                                        "customRegular"),
                                                  ),
                                                ),
                                                new Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0.0, 3, 0, 5.0),
                                                  //  height: 120.0,
                                                  //  width: 100.0,
                                                  child:
                                                  new Text(
                                                    lis[index].note,
/*
                                                    'Lorem ipsum dolor sit amet, consectetur adip isc ing elit. Arcu nibh venenatis.',
*/
                                                    style: new TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 12.0,
                                                        color: ColorValues.TEXT_COLOR,
                                                        fontFamily:
                                                        "customRegular"),
                                                  ),
                                                ),
                                                new Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0.0, 3, 0, 5.0),
                                                  //  height: 120.0,
                                                  //  width: 100.0,
                                                  child:
                                                  new Text(
                                                  lis[index].created,
                                                    /*"2 Hours Ago"*/
                                                    /*item.weight
                                                    .replaceAll(".00", "") +
                                                    " " +
                                                    item.unit*/
                                                    style: new TextStyle(
                                                        fontSize: 11.0,
                                                        color: ColorValues.TIME_NOTITFICAITON,

                                                        fontFamily:
                                                        "customLight"),
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
                                                                    new Container(
                                    height: 0.5,
                                    color: ColorValues.TIME_NOTITFICAITON,

                                  ),
                                ],),

                              ),

                            );
                          },
                        ),
                      ),
                    ),

                  ],
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                      valueColor:AlwaysStoppedAnimation<Color>(ColorValues.TEXT_COLOR),

                    ));
              }
            },
          ),
        ),
      );
    } else {

      return WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          //  }
        },
        child: Scaffold(
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
            Navigator.pop(context);

          },
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Notification',
          style: new TextStyle(
              color: ColorValues.TEXT_COLOR,
              fontWeight: FontWeight.w600,
              fontFamily: "customRegular",
              fontSize: 18.0),
        ),
      ),
    body:
        Center(
          child: isLoading?CircularProgressIndicator(
            valueColor:AlwaysStoppedAnimation<Color>(ColorValues.TEXT_COLOR),

          ):new Text("No Item Available",style: TextStyle(
            color: ColorValues.TEXT_COLOR,
            fontSize: 15.0,
            fontWeight: FontWeight.w600,

            fontFamily: "customLight",

          ),)
          )
          )

      );
    }
  }
}
