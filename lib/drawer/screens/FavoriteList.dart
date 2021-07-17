import 'dart:async';
import 'dart:convert' show json;
import 'dart:convert';

//import 'package:razorpay_plugin/razorpay_plugin.dart';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'package:yaamfoo/drawer/sidemenu/side_menu.dart';
import 'package:yaamfoo/values/ColorValues.dart';

import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

class FavoriteList extends StatefulWidget {
  String type = "";

  FavoriteList({Key key, this.type}) : super(key: key);

  Msg _mData;
  SharedPreferences prefs;

  //MyCart(this.type, this._mData);

  static final String route = "Cart-route";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FavoriteState();
  }
}

class FavoriteState extends State<FavoriteList> {
  String type = "";
  var isLoading = false;
  var isdata= false;

  SharedPreferences prefs;
  List<Favorite> favoriteList = new List();
  favoriteModel _homeModel;

  productApi(id) async {
    // set up POST request arguments
    setState(() {
      isLoading = true;
      isdata = true;
    });

    try {
      print("body+++++");
      //  CustomProgressLoader.showLoader(context);
      var url = Uri.parse(ApiConstant.FAVORITE_LIST + id);
      Map<String, String> headers = {"Content-type": "application/json"};
      Response response = await get(url, headers: headers);
      // check the status code for the result
      int statusCode = response.statusCode;
      // this API passes back the id of the new item added to the body
      String body = response.body;
      print("response+++" + body);
      var data = json.decode(body);
      if (data["status"].toString() == "201") {
     // if (body.statusCode == 200) {
        favoriteList = [];
        _homeModel = favoriteModel.fromJson(json.decode(body));
        setState(() {
          favoriteList.addAll(_homeModel.data.favorite);
          isdata = false;
          isLoading = false;
        });
      }else{
        setState(() {
          isLoading = false;

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
    /* if (SchedulerBinding.instance.schedulerPhase ==
          SchedulerPhase.persistentCallbacks) {
        SchedulerBinding.instance.addPostFrameCallback((_) => ));
      }*/

    //_email=prefs.getString(Constant.USER_EMAIL);
    //_name=prefs.getString(Constant.USER_NAME);
  }

  @override
  Widget build(BuildContext context) {
    Constant.applicationContext = context;

    if (!isdata) {
      return Scaffold (
        drawer: SideMenu(),

        appBar: new AppBar(
          elevation: 0.0,
          leading: Builder(
            builder: (BuildContext context) {
              return
                new InkWell(
                  child:Container(
                    padding: EdgeInsets.all(20.0),
                    //  margin: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                    child:new Image.asset(
                      'image/back_arrow.png',
                      width: 10.0,
                      height: 10,
                      color: ColorValues.TEXT_COLOR,
                    ),
                  ),
                  onTap: ()=>Scaffold.of(context).openDrawer(),
                );
            },
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Favorite',
            style: new TextStyle(
                color: ColorValues.TEXT_COLOR,
                fontWeight: FontWeight.w600,
                fontFamily: "customRegular",
                fontSize: 18.0),
          ),
        ),
        body: isLoading
            ? new Center(child: new CircularProgressIndicator(
          valueColor:AlwaysStoppedAnimation<Color>(ColorValues.TEXT_COLOR),

        ))
            : FutureBuilder<List<Dbmodel>>(
          future: DBProvider.db.getAllClients(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Dbmodel>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.48,
                      child: ListView.builder(
                        itemCount: favoriteList.length,
                        itemBuilder: (BuildContext context, int index) {
                          // Dbmodel item = snapshot.data[index];
                          return new GestureDetector(
                            child: Container(
                              margin:
                              EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                              child: new Card(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin:
                                EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                child: new Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Expanded(
                                      child: new Container(
                                          height: 100.0,
                                          width: 100.0,

                                          // color: Colors.transparent,
                                          decoration: BoxDecoration(

                                            //  color: Colors.white,
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                      'image/fav_back.png'))),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(0.0),
                                            child: Image.network(
                                              ApiConstant.IMAGE_BASE_URL +
                                                  favoriteList[index]
                                                      .food
                                                      .photo,
                                              height: 70.0,
                                              width: 70.0,
                                            ),
                                            /*new CachedNetworkImage(

                                                imageUrl:"https://toppng.com/uploads/preview/burger-11528340630dx5paxa77f.png"
                                                */ /*profileInfoModal != null
                          ?*/ /*
                                               */ /* Constant.CONSTANT_IMAGE_PATH +
                                                    item.defaultImage*/ /*
                                                */ /*: ""*/ /*,
                                                fit: BoxFit.cover,

                                              ),*/
                                          )),
                                      flex: 0,
                                    ),
                                    new Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10.0, 0, 0, 0),
                                        child: new Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0.0, 0, 0, 5.0),
                                          //  height: 120.0,
                                          //  width: 100.0,
                                          child: new Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,

                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              PaddingWrap.paddingfromLTRB(
                                                  0.0,
                                                  10.0,
                                                  0.0,
                                                  5.0,
                                                  new InkWell(
                                                      child: new Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 0,
                                                            child:
                                                            Image.asset(
                                                              'image/start.png',
                                                              height: 8.0,
                                                              width: 8.0,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 8,
                                                            child:
                                                            new Padding(
                                                              padding: EdgeInsets
                                                                  .fromLTRB(
                                                                  2.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                              child:
                                                              new Text(
                                                                "4.9 (105)",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    'customLight',
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                    fontSize:
                                                                    8.0,
                                                                    color: Color(
                                                                        ColorValues.HEADING_COLOR_EDUCATION)),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      onTap: () {})),
                                              new Container(
                                                margin: const EdgeInsets
                                                    .fromLTRB(
                                                    0.0, 0, 0, 5.0),
                                                //  height: 120.0,
                                                //  width: 100.0,
                                                child: new Text(
                                                  favoriteList[index]
                                                      .food
                                                      .foodName,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      fontSize: 13.0,
                                                      color: ColorValues
                                                          .TEXT_COLOR,
                                                      fontFamily:
                                                      "customRegular"),
                                                ),
                                              ),
/*
                                          new Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0.0, 0, 0, 5.0),
                                            //  height: 120.0,
                                            //  width: 100.0,
                                            child:
                                              new Text("spicy and crispy with garlic"
                                                */
/*item.weight
                                                    .replaceAll(".00", "") +
                                                    " " +
                                                    item.unit*/ /*
,
                                                style: new TextStyle(
                                                    fontSize: 11.0,
                                                    color: ColorValues.TEXT_COLOR,

                                                    fontFamily:
                                                    "customRegular"),
                                              ),
                                              ),
*/
                                              new Container(
                                                margin: const EdgeInsets
                                                    .fromLTRB(
                                                    0.0, 0, 0, 0.0),
                                                //  height: 120.0,
                                                //  width: 100.0,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .fromLTRB(
                                                      0.0, 8, 0, 0),
                                                  child: new Row(
                                                    children: [
                                                      new Text(
                                                          "₹ ${favoriteList[index].food.price}",
                                                          style: new TextStyle(
                                                              fontSize:
                                                              13.0,
                                                              color: ColorValues
                                                                  .TEXT_COLOR,
                                                              fontFamily:
                                                              "customBold")),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            10.0,
                                                            0,
                                                            0,
                                                            0),
                                                        child: new Stack(
                                                          children: [
                                                            new Text("",
                                                                style: new TextStyle(
                                                                    decorationColor:
                                                                    Colors
                                                                        .black,
                                                                    decorationStyle:
                                                                    TextDecorationStyle
                                                                        .solid,
                                                                    decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                    decorationThickness:
                                                                    3.0,
                                                                    fontSize:
                                                                    14.0,
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                    "muktaRegular")),
                                                            /*Center(
                                                                            child:
                                                                                Padding(
                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              0.0,
                                                                              10,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              new Container(
                                                                            height:
                                                                                1.0,
                                                                            width:
                                                                                50.0,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        ),*/
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
                                      ),
                                      flex: 1,
                                    ),
                                    new Expanded(
                                      child: new Container(
                                        height: 100.0,
                                        // width: 100.0,
                                        child: new Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  5.0, 10.0, 10.0, 0),
                                              child: new Image.asset(
                                                "image/favorite.png",
                                                width: 15.0,
                                                height: 15.0,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  10.0, 10, 5, 10),
                                              child: new Row(
                                                children: [
                                                  new InkWell(
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(5.0),
                                                      child:
                                                      new Image.asset(
                                                        "image/plus.png",
                                                        width: 15.0,
                                                        height: 15.0,
                                                      ),
                                                    ),
                                                    /*onTap: () {
                                                        double dis = double
                                                            .parse(item
                                                            .price) -
                                                            double.parse(item
                                                                .offerprice);
                                                        DBProvider.db
                                                            .IncrementClient(
                                                            item.product_id,
                                                            item.price,
                                                            item.total,
                                                            item.cartquantity,
                                                            item.discount,
                                                            dis.toString());
                                                        _calcTotal();

                                                        setState(() {});

                                                      }*/
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      flex: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {},
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator(
                valueColor:AlwaysStoppedAnimation<Color>(ColorValues.TEXT_COLOR),

              ));
            }
          },
        ),
      );
    }else{
      return Scaffold (
          drawer: SideMenu(),

          appBar: new AppBar(
            elevation: 0.0,
            leading: Builder(
              builder: (BuildContext context) {
                return
                  new InkWell(
                    child:Container(
                      padding: EdgeInsets.all(20.0),
                      //  margin: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                      child: new Image.asset(
                        'image/back_arrow.png',
                        width: 10.0,
                        height: 10,
                        color: ColorValues.TEXT_COLOR,
                      ),

                    ),
                    onTap: ()=>Scaffold.of(context).openDrawer(),
                  );
              },
            ),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Favorite',
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
    );
    }

  }
}
