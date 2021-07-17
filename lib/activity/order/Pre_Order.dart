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
import 'package:yaamfoo/Model/O_model.dart';
import 'package:yaamfoo/Model/ProductModel.dart';
import 'package:yaamfoo/activity/order/OrderDetail.dart';
import 'package:yaamfoo/comman/ApiConstant.dart';
import 'package:yaamfoo/comman/CustomProgressLoader.dart';
import 'package:yaamfoo/constant/Padding_Wrap.dart';
import 'package:yaamfoo/constant/Constant.dart';
import 'package:yaamfoo/database/DBProvider.dart';
import 'package:yaamfoo/values/ColorValues.dart';
import 'package:http/http.dart';

class Pre_Order extends StatefulWidget {
  String type = "";

  Msg _mData;
  SharedPreferences prefs;

  //MyCart(this.type, this._mData);

  static final String route = "Cart-route";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Pre_OrderState();
  }
}

class Pre_OrderState extends State<Pre_Order> {
  String type = "";
  var isdata= false;
  var isLoading= false;
  SharedPreferences prefs;
  List<Dbmodel> cart = [];
  List<O_model> lis= new List();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
    // setState(() => coupan = '${widget.code}');
    // _calcTotal();
    setState(() {});

    wishlist();
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }


  Future<String> wishlist() async {
    try {
        setState(() {
        isLoading = true;
        isdata = true;

        });
      SharedPreferences prefs = await SharedPreferences.getInstance();

     // CustomProgressLoader.showLoader(context);
      var url =Uri.parse(ApiConstant.ORDER_DETAILS);
      Map<String, String> headers = {"Content-type": "application/json"};
      Map map = {
        "user": prefs.getString(Constant.USER_ID),
        "order_status":"DELEVERED"
      };
      // make POST request
      Response response =
      await post(url, headers: headers, body: json.encode(map));

      String body = response.body;
    //  CustomProgressLoader.cancelLoader(context);
      var data = json.decode(body);

      String status = data['status'].toString();

      if (status == "201") {

        for (var word in data['data']['order']) {
          String id = word["id"].toString();
          String status = word["status"].toString();
          String deleted = word["deleted"].toString();
          String created_at = word["created_at"].toString();
          String updated_at = word["updated_at"].toString();
          String delivery_price = word["delivery_price"].toString();
          String discount_price = word["discount_price"].toString();
          String cgst_price = word["cgst_price"].toString();
          String sgst_price = word["sgst_price"].toString();
          String igst_price = word["igst_price"].toString();
          String final_price = word["final_price"].toString();
          String city = word["city"].toString();
          String state = word["state"].toString();
          String pincode = word["pincode"].toString();
          String address = word["address"].toString();
          String order_time = word["order_time"].toString();
          String delevered_time = word["delevered_time"].toString();
          String order_status = word["order_status"].toString();
          String comment = word["comment"].toString();
          String otp = word["otp"].toString();
          String user = word["user"].toString();
          String restaurant = word["restaurant"].toString();

          setState(() {
            isdata = false;

            lis.add(O_model (id, status, deleted, created_at, updated_at,
                delivery_price, discount_price, cgst_price, sgst_price,
                igst_price,final_price,city,state,
                pincode,address,order_time,delevered_time,
                order_status,comment,otp,user,restaurant));
          });

        }
      } else {

      }

//var array = data['data'];
      print('RESPONCE_DATA : ' + status);
      setState(() {
        isLoading = false;
      });
    }
    /*else {
        CustomProgressLoader.cancelLoader(context);
        Fluttertoast.showToast(
            msg: "Please check your internet connection....!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
        // ToastWrap.showToast("Please check your internet connection....!");
        // return response;
      }
    }*/
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
      return Scaffold(

        body: FutureBuilder<List<Dbmodel>>(
          future: DBProvider.db.getAllClients(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Dbmodel>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.48,
                      child: ListView.builder(
                        itemCount:lis.length,
                        itemBuilder: (BuildContext context, int index) {
                          // Dbmodel item = snapshot.data[index];
                          return new GestureDetector(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                              child: new Card(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(

                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin:
                                EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                child:
                                new Row
                                  (
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
                                                  fit: BoxFit.fill, image: AssetImage('image/fav_back.png'))),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(0.0),
                                            child:
                                            Image.asset(
                                              'image/burger.png',
                                              height: 70.0,
                                              width: 70.0,
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
                                                            child:  Image.asset(
                                                              'image/start.png',
                                                              height: 8.0,
                                                              width: 8.0,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 8,
                                                            child:new Padding(
                                                              padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                                                              child: new Text(
                                                                "4.9 (105)",
                                                                style: TextStyle(
                                                                    fontFamily: 'customLight',
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 8.0,
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
                                              new Container(
                                                margin: const EdgeInsets.fromLTRB(
                                                    0.0, 0, 0, 5.0),
                                                //  height: 120.0,
                                                //  width: 100.0,
                                                child:
                                                new Text(
                                                  'Veggie Burgers',
                                                  style: new TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 13.0,
                                                      color: ColorValues.TEXT_COLOR,
                                                      fontFamily:
                                                      "customRegular"),
                                                ),
                                              ),
                                              new Container(
                                                margin: const EdgeInsets.fromLTRB(
                                                    0.0, 0, 0, 5.0),
                                                //  height: 120.0,
                                                //  width: 100.0,
                                                child:
                                                new Text("spicy and crispy with garlic"
                                                  /*item.weight
                                                    .replaceAll(".00", "") +
                                                    " " +
                                                    item.unit*/,
                                                  style: new TextStyle(
                                                      fontSize: 11.0,
                                                      color: ColorValues.TEXT_COLOR,

                                                      fontFamily:
                                                      "customRegular"),
                                                ),
                                              ),
                                              new Container(
                                                margin: const EdgeInsets.fromLTRB(
                                                    0.0, 0, 0, 0.0),
                                                //  height: 120.0,
                                                //  width: 100.0,
                                                child:
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0.0, 8, 0, 0),
                                                  child: new Row(
                                                    children: [
                                                      new Text(
                                                          lis[index].createdat,
                                                          style: new TextStyle(
                                                              fontSize: 8.0,
                                                              color: ColorValues.TEXT_COLOR,
                                                              fontFamily:
                                                              "customLight")),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .fromLTRB(
                                                            5.0, 0, 0, 0),
                                                        /* child: new Stack(
                                                            children: [
                                                              new Text(
                                                                  "11:25 am",
                                                                  style: new TextStyle(


                                                                      fontSize:
                                                                      8.0,
                                                                      color: ColorValues.TEXT_COLOR,

                                                                      fontFamily:
                                                                      "customLight")),
                                                              *//*Center(
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
                                                                        ),*//*
                                                            ],
                                                          ),*/
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
                                      child:new Container(
                                        height: 100.0,
                                        // width: 100.0,
                                        child:
                                        new Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  5.0, 10.0, 10.0, 0),
                                              child:  new Text(
                                                  lis[index].finalprice,
                                                  style: new TextStyle(
                                                      fontSize: 13.0,
                                                      color: ColorValues.TEXT_COLOR,
                                                      fontFamily:
                                                      "customBold")),
                                            ),
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
    }
    else {
      return Scaffold (
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
