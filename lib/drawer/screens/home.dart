import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yaamfoo/Model/homeModel.dart';
import 'package:yaamfoo/Model/homeModel.dart';
import 'package:yaamfoo/Model/homeModel.dart';
import 'package:yaamfoo/activity/SeeAllRestaurent.dart';
import 'package:yaamfoo/activity/order/ProductDescription.dart';

import 'package:yaamfoo/activity/order/ProductDetails.dart';
import 'package:yaamfoo/activity/profilemenu/NotificationList.dart';
import 'package:yaamfoo/comman/ApiConstant.dart';
import 'package:yaamfoo/comman/CustomProgressLoader.dart';
import 'package:yaamfoo/constant/Constant.dart';
import 'package:yaamfoo/constant/Padding_Wrap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
import 'package:yaamfoo/database/DBProvider.dart';
import 'dart:async';
import 'dart:convert';

import 'package:yaamfoo/drawer/sidemenu/side_menu.dart';
import 'package:yaamfoo/values/ColorValues.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool changecolore=true;
  SharedPreferences prefs;
  String _name,_email,userId;
  String sizeId="",sizeName="",sizePrice="0.0";

  List<Category> category= new List();
  List<Restaurant> restaurant= new List();
  List<PopularFood> popularFood= new List();

  homeModel _homeModel;
  var isLoading=false,favoriteLoad=false;
  productApi() async {
    // set up POST request arguments
    setState(() {
      isLoading=true;

    });

    try {
      print("body+++++");
      //  CustomProgressLoader.showLoader(context);
      var url =Uri.parse(ApiConstant.HOME_URL);
      Map<String, String> headers = {"Content-type": "application/json"};

      Response response = await get(url, headers: headers);
      // check the status code for the result
      int statusCode = response.statusCode;
      // this API passes back the id of the new item added to the body
      String body = response.body;
      print("response+++" + body);
      // CustomProgressLoader.cancelLoader(context);
      if (response.statusCode == 200) {
        category = [];
        restaurant = [];
        popularFood = [];
        _homeModel = homeModel.fromJson(json.decode(body));


        setState(() {
          category.addAll(_homeModel.data.category);
          restaurant.addAll(_homeModel.data.restaurant);
          popularFood.addAll(_homeModel.data.popularFood);

          setState(() {
            sizeId= '${popularFood[0].size[0].id}';
            sizeName= popularFood[0].size[0].size;
            sizePrice = '${popularFood[0].size[0].price}';
            popularFood[0].size[0].isSelect=true;

          });
          isLoading=false;

        });
      }
      print("body+++++" + body.toString());
    } catch (e) {
      print("Error+++++" + e.toString());
    }
  }

  void addFavorite(foodId,userId,index) async{

try {

          print("body+++++");
          CustomProgressLoader.showLoader(context);
          var url =Uri.parse(ApiConstant.ADD_FAVORITE);
          Map<String, String> headers = {"Content-type": "application/json"};
          Map map = {

            "food": foodId,
            "user": userId

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
              msg:Constant.ADD_FAVORITE,
              toastLength: Toast.LENGTH_SHORT,
              //    gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              //  backgroundColor: Colors.red,
              //   textColor: Colors.white,
              //  fontSize: 16.0
            );
            setState(() {
            popularFood[index].favorite=true;
            });
          } else if (data["status"].toString() == "400") {
            Fluttertoast.showToast(
              msg:Constant.ADD_FAVORITE,
              toastLength: Toast.LENGTH_SHORT,
              //    gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              //  backgroundColor: Colors.red,
              //   textColor: Colors.white,
              //  fontSize: 16.0
            );
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
          //  print("body+++++" + body.toString());
        } catch (e) {
          print("Error+++++" + e.toString());
          CustomProgressLoader.cancelLoader(context);

        }


  }
  void deleteFavorite( foodId,userId,index) async{

    try {
      String stringValue = foodId.toString();

      print("body+++++");
      CustomProgressLoader.showLoader(context);
      var url =Uri.parse(ApiConstant.DELETE_FAVORITE+userId+"&food="+stringValue);
      Map<String, String> headers = {"Content-type": "application/json"};

      // make POST request
      Response response =
      await get(url, headers: headers);
      // check the status code for the result
      // this API passes back the id of the new item added to the body
      String body = response.body;
      CustomProgressLoader.cancelLoader(context);
      var data = json.decode(body);
      if (data["status"].toString() == "201") {

        Fluttertoast.showToast(
          msg:Constant.DELETE_FAVORITE,
          toastLength: Toast.LENGTH_SHORT,
          //    gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          //  backgroundColor: Colors.red,
          //   textColor: Colors.white,
          //  fontSize: 16.0
        );
        setState(() {
          popularFood[index].favorite=false;
        });
      } else if (data["status"].toString() == "400") {
        Fluttertoast.showToast(
          msg:Constant.ADD_FAVORITE,
          toastLength: Toast.LENGTH_SHORT,
          //    gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          //  backgroundColor: Colors.red,
          //   textColor: Colors.white,
          //  fontSize: 16.0
        );
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
      //  print("body+++++" + body.toString());
    } catch (e) {
      print("Error+++++" + e.toString());
      CustomProgressLoader.cancelLoader(context);

    }


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();

    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) => productApi());
    }

  }
  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {

      userId=prefs.getString(Constant.USER_ID);
      _email=prefs.getString(Constant.USER_EMAIL);
      _name=prefs.getString(Constant.USER_NAME);

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),

      appBar: AppBar(
        backgroundColor: ColorValues.TEXT_COLOR,
        title:  new Container(
          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Image.asset('image/toolbar_light.png'),
          width: 100.0,
          //    height: 80.0,
        ),
        centerTitle: false,
        leading: Builder(
          builder: (BuildContext context) {
            return
              new InkWell(
                child:Container(
                  padding: EdgeInsets.fromLTRB(15.0,15.0,15.0,15.0),
                  //  margin: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                  child: new Image.asset('image/drawer.png',
                  ),
                  width: 10.0,
                  height: 10.0,
                ),
                onTap: ()=>Scaffold.of(context).openDrawer(),
              );
            /* RotatedBox(
              quarterTurns: 1,
              child: IconButton(
                icon: Icon(
                  Icons.stacked_bar_chart,
                  color: Colors.black,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            );*/
          },
        ),
        //backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          PaddingWrap.paddingfromLTRB(
            0.0, 13.0,
            10.0,
            13.0,
          new Container(
            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
              height: 15.0,
            width:120.0,
            decoration: BoxDecoration(
                color: ColorValues.TEXT_COLOR,
                border: Border.all(
                  color: Colors.white,
                  width: 0.5,
                )),
        //    margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
            child:new Center(
child:                       new InkWell(
    child:
    new Row(
      children: <Widget>[
        Expanded(
          flex: 0,
          child:  Image.asset(
            'image/shape.png',
            height: 15.0,
            width: 15.0,
            color: Colors.white,
          ),
        ),
        Expanded(
          flex: 0,
          child:new Padding(
            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
            child: new Text(
              "india",
              style: TextStyle(
                  fontFamily: 'customLight',
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                color: Colors.white,
              ),
            ),
          ),
        ),

      ],
    ),

)
              ,

          ),
          ),
    ),
          PaddingWrap.paddingfromLTRB(
              0.0,
              0.0,
              10.0,
              0.0,
              new Center(
                  child: new InkWell(
                    child: PaddingWrap.paddingfromLTRB(
                        0.0,
                        5.0,
                        0.0,
                        0.0,
                        new Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(3.0,3.0,3.0,3.0),
                              //  margin: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                              child: new Image.asset('image/notification.png',
                                color: Colors.white,
                                width: 20.0,
                                //height: 20.0,
                              ),
                              width: 30.0,
                              height: 30.0,
                            ),
                            new Positioned(
                                right: 6,
                                top: 0,
                                child: new Stack(
                                  children: <Widget>[
                                    new Icon(Icons.brightness_1,
                                        size:10.0,
                                        color: Colors.red[800]),
                                    new Positioned(
                                        top: 0.0,
                                        left: 0.0,
                                        right:0.0,
                                        bottom:0.0,
                                        child: new Center(
                                          child: new Text(
                                            "0",
                                            textAlign: TextAlign.center,
                                            style:
                                            new TextStyle(
                                              color:
                                              Colors.white,
                                              fontWeight:
                                              FontWeight
                                                  .w400,
                                              fontFamily:
                                              "customRegular",
                                              fontSize: 5.0,
                                            ),
                                          ),
                                        )),
                                  ],
                                )),
                          ],
                        )),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                            //   builder: (context) => new DashBoardWidget()));
                              builder: (context) =>
                              new NotificationList()));
                    },
                  ))),
        ],
      ),

      body:isLoading? new Center(child:new CircularProgressIndicator(
        valueColor:AlwaysStoppedAnimation<Color>(ColorValues.TEXT_COLOR),


      )): SingleChildScrollView(
        child: Center(
            child: Column(children: [
              Container(

                decoration: BoxDecoration(

                  //  color: Colors.white,
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage('image/corver.png'))),
                //  color: Color(0xff00F9FF),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 160.0,
                      child:
                      PaddingWrap.paddingfromLTRB(
                        18.0,
                        10.0,
                        18.0, 18.0,

                            new Padding(
                              padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                              child:
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  new Container(
                                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 3.0),
                                    alignment: Alignment.centerLeft,
                                    child:
                                    Text('Hi ${_name} !',

                                      style: TextStyle(
                                        color: Color(ColorValues.WHITE),
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w600,

                                        fontFamily: "customRegular",

                                      ),
                                    ),
                                  ),
                                  Row(children: <Widget>[
                                    new Container(
                                      margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 5.0),
                                      alignment: Alignment.centerLeft,
                                      child:
                                      Text('Find Your Fevorite',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color(ColorValues.WHITE),
                                          fontSize: 15.0,
                                          fontFamily: "customLight",

                                        ),),),
                                    new Container(
                                      margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 5.0),
                                      alignment: Alignment.centerLeft,
                                      child:
                                      Text('Food',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color:ColorValues.BACKGROUND,
                                          fontSize: 15.0,
                                          fontFamily: "customLight",

                                        ),),),

                                  ],

                                  ),
                                  PaddingWrap.paddingfromLTRB(10.0, 0.0, 20.0, 0.0,
                                  Row(
                                    children: <Widget>[
                                    new Expanded(child:
                                    Container(
                                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffffffff),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child:
                                        new Center(
                                            child: Container(

                                              padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                              child: new TextField(
                                                style: TextStyle(
                                                  color: ColorValues.TEXT_COLOR,
                                                  fontSize: 15.0,
                                                  fontFamily: "customLight",

                                                ),

                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                             //   textAlignVertical: TextAlignVertical.center,
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
                                                          color: ColorValues.TIME_NOTITFICAITON,
                                                          style: BorderStyle.none))),
                                            ))
                                    ),
                                        flex:6

                                    ),
                                    new Expanded(child:

                                    Container(
                                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                                      height: 40.0,
                                      width: 40.0,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffffffff),
                                        border: Border.all(
                                          color: Colors.white,
                                          width:8,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),


                                      child: Image.asset(
                                        'image/filter.png',
                                        fit: BoxFit.contain,
                                        width: 15,
                                        height: 15,

                                      ),
                                     // alignment: Alignment.bottomCenter,



                                    ),
                                        flex:0

                                    ),
                                  ],

                                  )
                                  )
                                ],
                              ),
                            )

                      ),

                    ),




                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 3.0),
                alignment: Alignment.centerLeft,
                child:
                Text('Categories',

                  style: TextStyle(
                    color:ColorValues.TEXT_COLOR,
                    fontWeight: FontWeight.w600,
                    fontFamily: "customRegular",
                    fontSize: 15.0,
                  ),
                ),
              ),


              Container(
                  margin: EdgeInsets.fromLTRB(10, 00, 00, 00),
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return
                        GestureDetector(
                            onTap: () {
                            /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ProductDetails()));*/
                            },
                            child:Card(
                                shape: RoundedRectangleBorder(

                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(

                                  margin: EdgeInsets.fromLTRB(00, 00, 00, 00),
                                  padding: EdgeInsets.all(5),


                                  child:
                                  Column(
                                    children: <Widget>[
                                      category[index].image!=null && category[index].image!=""?Container(
                                        width: 70,
                                        height: 70,

                                        child: Image.network(ApiConstant.IMAGE_BASE_URL+category[index].image,
                                          fit: BoxFit.contain,
                                        ),

                                        alignment: Alignment.topCenter,
                                      ):
                                      Container(
                                        child: Image.asset(
                                          'image/burger.png',
                                          fit: BoxFit.contain,
                                          width: 70,
                                          height: 70,

                                        ),
                                        alignment: Alignment.topCenter,
                                      ),
                                      Container(
                                          margin: EdgeInsets.fromLTRB(00, 03,00, 10.0),
                                          alignment: Alignment.center,
                                          child: Text(category[index].categoryName,style: TextStyle(fontSize: 12,
                                              color:Colors.black,
                                              fontWeight: FontWeight.w600),)
                                      ),
                                      changecolore?
                                      new GestureDetector(
                                          onTap: () {
                                            changecolore = false;
                                          },
                                          child: Container(
                                            child: Image.asset(
                                              'image/circle_arrow.png',
                                              fit: BoxFit.contain,
                                              width: 10,
                                              height: 10,
                                            ),
                                            alignment: Alignment.bottomCenter,
                                          )):
                                      new GestureDetector(
                                          onTap: () {
                                            changecolore = true;
                                          },
                                          child: Container(
                                            child: Image.asset(
                                              'image/call.png',
                                              fit: BoxFit.contain,
                                              width: 10,
                                              height: 10,
                                            ),
                                            alignment: Alignment.bottomCenter,
                                          )),
                                    ],
                                  ),
                                )
                            )
                        );
                    },
                    itemCount: category.length,
                  )
              ),
              Row(
                children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width/1.3,
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 3.0),
                  alignment: Alignment.centerLeft,
                  child:
                  Text('Restaurants Nearby',
                    style: TextStyle(
                      color:ColorValues.TEXT_COLOR,
                      fontWeight: FontWeight.w600,
                      fontFamily: "customRegular",
                      fontSize: 15.0,
                    ),
                  ),
                ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                            //   builder: (context) => new DashBoardWidget()));
                              builder: (context) =>
                              new SeeAllRestaurent()));
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 3.0),
                      alignment: Alignment.centerLeft,
                      child:
                      Text('see all',
                        style: TextStyle(
                          color:ColorValues.TEXT_COLOR,
                          fontFamily: "customLight",
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),


              ],),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 00, 00, 00),
                  height: 240,

                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ProductDetails(id: restaurant[index].id.toString(),)));
                            },
                            child:Card(
                             //   semanticContainer: true,
                              //  clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(

                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  width: 260,

                                  margin: EdgeInsets.fromLTRB(00, 00, 00, 00),
                                  padding: EdgeInsets.all(0),
                                  child:
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                          'image/full_burger.png',
                                          fit: BoxFit.contain,
                                          height: 140,
                                          width: 260,
                                        ),
                                        alignment: Alignment.topCenter,
                                      ),
                                      Container(
                                          margin: EdgeInsets.fromLTRB(10, 10,00, 05),
                                        //  alignment: Alignment.,
                                          child: Text(restaurant[index].restaurantName,style: TextStyle(fontSize: 14,
                                              color:ColorValues.TEXT_COLOR,
                                              fontFamily: 'customRegular',
                                              fontWeight: FontWeight.w600),)
                                      ),
                                      Row(children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.fromLTRB(10.0, 00.0, 0.0, 0.0),
                                          alignment: Alignment.centerLeft,
                                          child:
                                          Text(restaurant[index].restaurantName,

                                            style: TextStyle(
                                              color:ColorValues.TEXT_COLOR,
                                              fontSize: 10.0,

                                              fontFamily: "customLight",

                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(5.0, 2.0, 0.0, 0.0),
                                          height: 5.0,
                                          width: 5.0,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff000000),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(05.0, 00.0, 0.0, 0.0),
                                          alignment: Alignment.centerLeft,
                                          child:
                                          Text(restaurant[index].restaurantName,
                                            style: TextStyle(
                                              color:ColorValues.TEXT_COLOR,
                                              fontSize: 10.0,

                                              fontFamily: "customLight",

                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(5.0, 2.0, 0.0, 0.0),
                                          height: 5.0,
                                          width: 5.0,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff000000),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(05.0, 00.0, 0.0, 0.0),
                                          alignment: Alignment.centerLeft,
                                          child:
                                          Text('',

                                            style: TextStyle(
                                              color:ColorValues.TEXT_COLOR,
                                              fontSize: 10.0,

                                              fontFamily: "customLight",

                                            ),
                                          ),
                                        ),
                                      ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                        Row(children: [
                                        Container(
                                          margin: EdgeInsets.fromLTRB(10.0, 05.0, 0.0, 0.0),
                                          child: Image.asset(
                                            'image/start.png',
                                            fit: BoxFit.fitWidth,
                                            width: 10,
                                            height: 10,

                                          ),
                                          alignment: Alignment.topCenter,
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(05.0, 05.0, 0.0, 0.0),
                                          alignment: Alignment.centerLeft,
                                          child:
                                          Text('4.9',

                                            style: TextStyle(
                                              color:ColorValues.TEXT_COLOR,
                                              fontSize: 10.0,

                                              fontFamily: "customLight",

                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width/3.4,
                                          margin: EdgeInsets.fromLTRB(05.0, 05.0, 0.0, 0.0),
                                          alignment: Alignment.centerLeft,
                                          child:
                                          Text('(105)',

                                            style: TextStyle(
                                              color:ColorValues.TEXT_COLOR,
                                              fontSize: 10.0,

                                              fontFamily: "customLight",

                                            ),
                                          ),
                                        ),
                                        ],),

                                        Container(
                                            margin: EdgeInsets.fromLTRB(00.0, 05.0, 10.0, 0.0),
                                            padding: EdgeInsets.all(03),
                                            decoration: BoxDecoration(
                                              color: const Color(0xff000000),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Row(children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.fromLTRB(00.0, 00.0, 0.0, 0.0),
                                                child: Image.asset(
                                                  'image/clock.png',
                                                  fit: BoxFit.fitWidth,
                                                  color: ColorValues.BACKGROUND,
                                                  width: 8,
                                                  height: 8,

                                                ),
                                                alignment: Alignment.topCenter,
                                              ),
                                              Container(

                                                margin: EdgeInsets.fromLTRB(05.0, 00.0, 0.0, 0.0),
                                                alignment: Alignment.centerLeft,
                                                child:
                                                Text('30 min',
                                                  style: TextStyle(
                                                    color: ColorValues.BACKGROUND,
                                                    fontSize: 8.0,

                                                    fontFamily: "customLight",

                                                  ),
                                                ),
                                              ),
                                            ]
                                            )
                                        )


                                      ],)


                                    ],
                                  ),
                                )
                            )
                        );
                    },
                    itemCount: restaurant.length,
                  )
              ),

              Container(
                margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 3.0),
                alignment: Alignment.centerLeft,
                child:
                Text('Popular Now',

                  style: TextStyle(
                    color:ColorValues.TEXT_COLOR,
                    fontWeight: FontWeight.w600,
                    fontFamily: "customRegular",
                    fontSize: 15.0,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 00, 00, 00),
                  height: 120,


                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return new GestureDetector(
                        child:
                        Container(
                          width: 280.0,
                          margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                          child: new Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(

                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin:
                            EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                            child:
                            new Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Expanded(
                                  child: new Container(
                                      height: 120.0,
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
                                        Image.network(
                                          ApiConstant.IMAGE_BASE_URL+popularFood[index].photo,
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
                                              '${popularFood[index].foodName}',
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13.0,
                                                  color: ColorValues.TEXT_COLOR,
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
                                            new Text(""
                                              */
/*item.weight
                                                    .replaceAll(".00", "") +
                                                    " " +
                                                    item.unit*//*
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
                                                      "₹ ${popularFood[index].price}",
                                                      style: new TextStyle(
                                                          fontSize: 13.0,
                                                          color: ColorValues.TEXT_COLOR,
                                                          fontFamily:
                                                          "customBold")),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        10.0, 0, 0, 0),
                                                    child: new Stack(
                                                      children: [
                                                        new Text(
                                                            "",
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
                                          child:
                                          new GestureDetector(
                                            child:
                                          new Image.asset(popularFood[index].favorite==true?"image/favorite.png":
                                            "image/heart_line.png",
                                            width: 15.0,
                                            height: 15.0,
                                          ),
                                          onTap: (){
                                            popularFood[index].favorite==true?deleteFavorite(popularFood[index].id,userId,index):   addFavorite(popularFood[index].id,userId,index);
                                          },
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
                                                  child: new Image.asset(
                                                    "image/plus.png",
                                                    width: 15.0,
                                                    height: 15.0,
                                                  ),
                                                ),
                                                onTap: (){

                                                  showModalBottomSheet(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                                                      ),

                                                      context: context,
                                                      builder: (context) {
    return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
      return
        SingleChildScrollView(child:
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0)),
            color: Colors.white,
          ),
          width: MediaQuery
              .of(context)
              .size
              .width,
          // color: Colors.white,
          child:

          Container(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
            //    height: 1200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                PaddingWrap.paddingfromLTRB(
                  5.0,
                  5.0,
                  0.0,
                  0.0,
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(5.0, 5, 15, 5),
                    child: new Row(
                      children: [
                        new Expanded(
                          child: new Text(
                            popularFood[index].foodName,
                            style: new TextStyle(
                                fontFamily: "customRegular",
                                color: ColorValues.TEXT_COLOR,
                                fontSize: 15),
                          ),
                          flex: 1,
                        ),
                        new Expanded(
                          child: new Text(

                            "₹ ${ popularFood[index].price}",
                            style: new TextStyle(
                                fontFamily: "customRegular",
                                color: ColorValues.YELLOW,
                                fontSize: 15),
                          ),
                          flex: 0,
                        )
                      ],
                    ),
                  ),

                ),
                PaddingWrap.paddingfromLTRB(
                  5.0,
                  5.0,
                  0.0,
                  0.0,
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(5.0, 5, 15, 5),
                    child: new Row(
                      children: [
                        new Expanded(
                          child: new Text(
                            popularFood[index].foodName,
                            style: new TextStyle(
                                fontFamily: "customLight",
                                color: ColorValues.TEXT_COLOR,
                                fontSize: 14),
                          ),
                          flex: 1,
                        ),
                        new Expanded(
                          child: new Text(
                            "",
                            style: new TextStyle(
                                fontFamily: "customLight",
                                color: ColorValues.TEXT_COLOR,
                                fontSize: 14),
                          ),
                          flex: 0,
                        )
                      ],
                    ),
                  ),

                ),
                PaddingWrap.paddingfromLTRB(
                  5.0,
                  5.0,
                  0.0,
                  5.0,
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(5.0, 5, 15, 5),
                    child:
                    new Row(

                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new Expanded(
                          child:
                          new Row(
                            children: <Widget>[
                              Image.asset(
                                'image/start.png',
                                height: 13.0,
                                width: 13.0,
                              ),

                              new Padding(
                                padding: EdgeInsets.fromLTRB(
                                    3.0, 0.0, 0.0, 0.0),
                                child: new Text(
                                  "4.9 (105)",
                                  style: TextStyle(
                                      fontFamily: 'customLight',
                                      fontSize: 14.0,
                                      color: ColorValues.TEXT_COLOR),
                                ),
                              ),


                            ],
                          ),
                          flex: 0,
                        ),
                        new Expanded(
                          child:
                          new Row(
                            children: <Widget>[
                              Image.asset(
                                  'image/clock.png',
                                  height: 13.0,
                                  width: 13.0,
                                  color: ColorValues.TEXT_COLOR
                              ),

                              new Padding(
                                padding: EdgeInsets.fromLTRB(
                                    2.0, 0.0, 0.0, 0.0),
                                child: new Text(
                                  "30 MIN",
                                  style: TextStyle(
                                      fontFamily: 'customLight',
                                      fontSize: 14.0,
                                      color: ColorValues.TEXT_COLOR),
                                ),
                              ),


                            ],
                          ),
                          flex: 0,
                        ),

                        new Expanded(
                          child: new Text(
                            "Free Delivery",
                            style: new TextStyle(
                                fontFamily: "customLight",
                                color: ColorValues.CALL_COLOR,
                                fontSize: 14),
                          ),
                          flex: 0,
                        ),
                      ],
                    ),
                  ),

                ),
                new Container(
                  margin: EdgeInsets.fromLTRB(00.0, 5.0, 0.0, 5.0),

                  height: 0.5,
                  color: ColorValues.TIME_NOTITFICAITON,
                ),
                new Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                  child: new Text(
                    "Size",
                    style: TextStyle(
                        fontFamily: 'customLight',
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                        color: Color(ColorValues.HEADING_COLOR_EDUCATION)),
                  ),
                ),

                PaddingWrap.paddingfromLTRB(
                  5.0,
                  5.0,
                  0.0,
                  5.0,
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(5.0, 5, 15, 5),
                    child:
                    new Row(

                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

new Expanded(
                    child:
                    InkWell(child:
                    Container(

                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                    width: 100.0,
                    height: 40.0,


                    child: Card(

                      elevation: 5.0,
                      color:popularFood[index].size[0].isSelect?ColorValues.TEXT_COLOR:Colors.white,
                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(2),
                      ),
                      child:  Container(

                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                        width: 100.0,
                        height: 40.0,
                        alignment: Alignment.center,


                        child: Text(
                          "${popularFood[index].size[0].size}",
                          textAlign: TextAlign.center,
                          style: TextStyle(

                            color:popularFood[index].size[0].isSelect?Colors.white:ColorValues.TEXT_COLOR,
                            fontFamily: "customLight",
                            fontSize: 13.0,
                          ),
                        ),
                      ),
                    ),
                  ),

              onTap: (){
  setState(() {
    sizeId= '${popularFood[index].size[0].id}';
    sizeName= popularFood[index].size[0].size;
    sizePrice = '${popularFood[index].size[0].price}';
    popularFood[index].size[0].isSelect=true;
    popularFood[index].size[1].isSelect=false;

  });

},
), flex: 0,
),
                        new Expanded(
                          child:
                          InkWell(child:
                          Container(

                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                            width: 100.0,
                            height: 40.0,


                            child: Card(

                              elevation: 5.0,
                              color:popularFood[index].size[1].isSelect?ColorValues.TEXT_COLOR:Colors.white,
                              shape: RoundedRectangleBorder(

                                borderRadius: BorderRadius.circular(2),
                              ),
                              child:  Container(

                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                width: 100.0,
                                height: 40.0,
                                alignment: Alignment.center,


                                child: Text(
                                  "${popularFood[index].size[1].size}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(

                                    color:popularFood[index].size[1].isSelect?Colors.white:ColorValues.TEXT_COLOR,
                                    fontFamily: "customLight",
                                    fontSize: 13.0,
                                  ),
                                ),
                              ),
                            ),
                          ),

                            onTap: (){
                              setState(() {
                                sizeId= '${popularFood[index].size[1].id}';
                                sizeName= popularFood[index].size[1].size;
                                sizePrice = '${popularFood[index].size[1].price}';

                                popularFood[index].size[1].isSelect=true;
                                popularFood[index].size[0].isSelect=false;

                              });

                            },
                          ), flex: 0,
                        ),



/*
                                                                              new Expanded(
                                                                                child:
                                                                                Container(

                                                                                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                                                                                  width: 100.0,
                                                                                  height: 40.0,


                                                                                  child: Card(

                                                                                    elevation: 5.0,
                                                                                    color:Colors.white,
                                                                                    shape: RoundedRectangleBorder(

                                                                                      borderRadius: BorderRadius.circular(2),
                                                                                    ),
                                                                                    child:  Container(

                                                                                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                                                                      width: 100.0,
                                                                                      height: 40.0,
                                                                                      alignment: Alignment.center,


                                                                                      child: Text('Large',
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(

                                                                                          color:ColorValues.TEXT_COLOR,
                                                                                          fontFamily: "customLight",
                                                                                          fontSize: 13.0,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                flex: 0,
                                                                              ),
*/
                      ],
                    ),
                  ),

                ),

/*

                PaddingWrap.paddingfromLTRB(
                  5.0,
                  5.0,
                  0.0,
                  5.0,
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(5.0, 5, 15, 5),
                    child:
                    Container(

                        height: 40.0,
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,

                          itemBuilder: (BuildContext context, int subIndex) {
                            return
                              GestureDetector(
                                onTap: () {
    for (var i = 0; i < popularFood[index].size.length; i++) {

                                    if(subIndex==i){


                                      setState(() {
                                        sizeId= '${popularFood[index].size[subIndex].id}';
                                        sizeName= popularFood[index].size[subIndex].size;
                                        popularFood[index].size[subIndex].isSelect=true;

                                      });

                                    }else{
                                      setState(() {
                                        popularFood[index].size[subIndex].isSelect=false;


                                      });

                                    }
                                  }

                                },
                                child:

                                new Expanded(
                                  child:
                                  Container(

                                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                                    width: 100.0,
                                    height: 40.0,


                                    child: Card(

                                      elevation: 5.0,
                                      color:  popularFood[index].size[subIndex].isSelect? ColorValues.TEXT_COLOR:Colors.white,
                                      shape: RoundedRectangleBorder(

                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: Container(

                                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                        width: 100.0,
                                        height: 40.0,
                                        alignment: Alignment.center,


                                        child: Text(
                                          "${popularFood[index].size[subIndex].size}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(

                                            color:  !popularFood[index].size[subIndex].isSelect? ColorValues.TEXT_COLOR:Colors.white,
                                            fontFamily: "customLight",
                                            fontSize: 13.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                 // flex: 0,
                                ),

                              );
                          },
                          itemCount: popularFood[index].size.length,
                        )
                    ),
                  ),

                ),
*/


                new Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                  child: new Text(
                    "Extra",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'customLight',
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,

                        color: Color(ColorValues.HEADING_COLOR_EDUCATION)),
                  ),
                ),

/*
                PaddingWrap.paddingfromLTRB(
                  5.0,
                  5.0,
                  0.0,
                  5.0,
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(5.0, 5, 15, 5),
                    child:
                    Container(

                        height: 100.0,
                        margin: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,

                          itemBuilder: (BuildContext context, int extraIndex) {

                            return
                              GestureDetector(

                                child:

                                PaddingWrap.paddingfromLTRB(
                                  0.0,
                                  0.0,
                                  0.0,
                                  0.0,
                                  new Row(

                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      new Expanded(
                                        child:
                                        new Row(
                                          children: <Widget>[
                                            Image.asset(
                                              'image/burger.png',
                                              height: 20.0,
                                              width: 20.0,
                                            ),

                                            new Padding(
                                              padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                                              child: new Text(
                                                popularFood [index].subItem[extraIndex].foodSubName,
                                                style: TextStyle(
                                                    fontFamily: 'customLight',

                                                    fontSize: 14.0,
                                                    color: Color(ColorValues.HEADING_COLOR_EDUCATION)),
                                              ),
                                            ),


                                          ],
                                        ),
                                        flex: 0,
                                      ),
                                      new Expanded(
                                        child: new Text(
                                          "₹ ${popularFood[index].subItem[extraIndex].price}",
                                          style: new TextStyle(
                                              fontFamily: "customLight",
                                              color: ColorValues.YELLOW,
                                              fontSize: 14),
                                        ),
                                        flex: 0,
                                      ),
                                      new Expanded(
                                        child:
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(
                                              10.0, 5, 5, 0),
                                          child: new Row(
                                            children: [
                                              new InkWell(

                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(15.0),
                                                  child: new Image.asset(
                                                    "image/minus.png",
                                                    width: 15.0,
                                                    height: 15.0,
                                                  ),
                                                ),
                                                onTap: (){
                                                  setState(() {
                                                    if(popularFood [index].subItem[extraIndex].subQuantity==0){

                                                    }else{
                                                      popularFood [index].subItem[extraIndex].subQuantity--;

                                                    }

                                                  });
                                                },
                                              ),
                                              new Text(
                                                "${popularFood [index].subItem[extraIndex].subQuantity}",
                                                style: new TextStyle(
                                                    fontFamily:
                                                    "customBold",
                                                    fontSize: 13),
                                              ),
                                              new InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    popularFood [index].subItem[extraIndex].subQuantity++;

                                                  });
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(15.0),
                                                  child: new Image.asset(
                                                    "image/plus.png",
                                                    width: 15.0,
                                                    height: 15.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        flex: 0,
                                      )
                                    ],
                                  ),


                                ),

                              );
                          },
                          itemCount: popularFood [index].subItem.length,
                        )
                    ),
                  ),

                ),
*/

                PaddingWrap.paddingfromLTRB(
                  10.0,
                  0.0,
                  0.0,
                  0.0,
                  new Row(

                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Expanded(
                        child:
                        new Row(
                          children: <Widget>[
                            Image.asset(
                              'image/burger.png',
                              height: 20.0,
                              width: 20.0,
                            ),

                            new Padding(
                              padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                              child: new Text(
                                popularFood[index].subItem[0].foodSubName,
                                style: TextStyle(
                                    fontFamily: 'customLight',

                                    fontSize: 14.0,
                                    color: Color(ColorValues.HEADING_COLOR_EDUCATION)),
                              ),
                            ),


                          ],
                        ),
                        flex: 0,
                      ),
                      new Expanded(
                        child: new Text(
                          "₹ ${popularFood[index].subItem[0].price}",
                          style: new TextStyle(
                              fontFamily: "customLight",
                              color: ColorValues.YELLOW,
                              fontSize: 14),
                        ),
                        flex: 0,
                      ),
                      new Expanded(
                        child:
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(
                              10.0, 10, 5, 0),
                          child: new Row(
                            children: [
                              new InkWell(

                                child: Padding(
                                  padding:
                                  const EdgeInsets
                                      .all(15.0),
                                  child: new Image.asset(
                                    "image/minus.png",
                                    width: 15.0,
                                    height: 15.0,
                                  ),
                                ),
                                onTap: (){
                                  setState(() {
                                    if(popularFood [index].subItem[0].subQuantity==0){

                                    }else{
                                      popularFood [index].subItem[0].subQuantity--;

                                    }

                                  });
                                },
                              ),
                              new Text(
                                "${popularFood [index].subItem[0].subQuantity}",
                                style: new TextStyle(
                                    fontFamily:
                                    "customBold",
                                    fontSize: 13),
                              ),
                              new InkWell(
                                onTap: (){
                                  setState(() {
                                    popularFood [index].subItem[0].subQuantity++;

                                  });
                                },
                                child: Padding(
                                  padding:
                                  const EdgeInsets
                                      .all(15.0),
                                  child: new Image.asset(
                                    "image/plus.png",
                                    width: 15.0,
                                    height: 15.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        flex: 0,
                      )
                    ],
                  ),


                ),
                PaddingWrap.paddingfromLTRB(
                  10.0,
                  0.0,
                  0.0,
                  0.0,
                  new Row(

                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Expanded(
                        child:
                        new Row(
                          children: <Widget>[
                            Image.asset(
                              'image/burger.png',
                              height: 20.0,
                              width: 20.0,
                            ),

                            new Padding(
                              padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                              child: new Text(
                                popularFood[index].subItem[1].foodSubName,
                                style: TextStyle(
                                    fontFamily: 'customLight',

                                    fontSize: 14.0,
                                    color: Color(ColorValues.HEADING_COLOR_EDUCATION)),
                              ),
                            ),


                          ],
                        ),
                        flex: 0,
                      ),
                      new Expanded(
                        child: new Text(
                          "₹ ${popularFood[index].subItem[1].price}",
                          style: new TextStyle(
                              fontFamily: "customLight",
                              color: ColorValues.YELLOW,
                              fontSize: 14),
                        ),
                        flex: 0,
                      ),
                      new Expanded(
                        child:
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(
                              10.0, 0, 5, 10),
                          child: new Row(
                            children: [
                              new InkWell(

                                child: Padding(
                                  padding:
                                  const EdgeInsets
                                      .all(15.0),
                                  child: new Image.asset(
                                    "image/minus.png",
                                    width: 15.0,
                                    height: 15.0,
                                  ),
                                ),
                                onTap: (){
                                  setState(() {
                                    if(popularFood [index].subItem[1].subQuantity==0){

                                    }else{
                                      popularFood [index].subItem[1].subQuantity--;

                                    }

                                  });
                                },
                              ),
                              new Text(
                                "${popularFood [index].subItem[1].subQuantity}",
                                style: new TextStyle(
                                    fontFamily:
                                    "customBold",
                                    fontSize: 13),
                              ),
                              new InkWell(
                                onTap: (){
                                  setState(() {
                                    popularFood [index].subItem[1].subQuantity++;

                                  });
                                },
                                child: Padding(
                                  padding:
                                  const EdgeInsets
                                      .all(15.0),
                                  child: new Image.asset(
                                    "image/plus.png",
                                    width: 15.0,
                                    height: 15.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        flex: 0,
                      )
                    ],
                  ),


                ),
                new Container(
                  margin: EdgeInsets.fromLTRB(00.0, 5.0, 0.0, 5.0),

                  height: 0.5,
                  color: ColorValues.TIME_NOTITFICAITON,
                ),
                PaddingWrap.paddingfromLTRB(
                  5.0,
                  5.0,
                  0.0,
                  0.0,
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(5.0, 5, 15, 5),
                    child: new Row(
                      children: [
                        new Expanded(
                          child: new Text(
                            "Total",
                            style: new TextStyle(
                                fontFamily: "customRegular",
                                color: ColorValues.TEXT_COLOR,
                                fontSize: 15),
                          ),
                          flex: 1,
                        ),
                        new Expanded(
                          child: new Text(
                            "₹ ${(double.tryParse('${popularFood[index].quntity}') * double.tryParse('${sizePrice}'))+(double.tryParse('${popularFood[index].subItem[0].price}')*double.tryParse('${popularFood[index].subItem[0].subQuantity}'))+(double.tryParse('${popularFood[index].subItem[1].price}')*double.tryParse('${popularFood[index].subItem[1].subQuantity}'))}",
                            style: new TextStyle(
                                fontFamily: "customRegular",
                                color: ColorValues.YELLOW,
                                fontSize: 15),
                          ),
                          flex: 0,
                        )
                      ],
                    ),
                  ),

                ),

                PaddingWrap.paddingfromLTRB(
                  5.0,
                  5.0,
                  0.0,
                  0.0,
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(5.0, 5, 15, 5),
                    child: new Row(

                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new Expanded(
                          child:
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
                                          .all(15.0),
                                      child: new Image.asset(
                                        "image/minus.png",
                                        width: 20.0,
                                        height: 20.0,
                                      ),
                                    ),
                                    onTap: () {

                                      if
                                      (popularFood[index].quntity == 1) {

                                      } else {
                                        setState(() {
                                          popularFood[index].quntity--;
                                        });
                                      }
                                    }


                                ),
                                new Text(
                                  '${ popularFood[index].quntity}',
                                  style: new TextStyle(
                                      fontFamily:
                                      "customBold",
                                      fontSize: 15),
                                ),
                                new InkWell(
                                    child: Padding(
                                      padding:
                                      const EdgeInsets
                                          .all(15.0),
                                      child: new Image.asset(
                                        "image/plus.png",
                                        width: 20.0,
                                        height: 20.0,
                                      ),
                                    ),
                                    onTap: () {

                                      setState(() {
                                        popularFood[index].quntity++;
                                      });
                                    }),
                              ],
                            ),
                          ),

                          flex: 0,
                        ),
                        new Expanded(
                          child:
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(
                                10.0, 10, 5, 10),
                            child:
                            new Container(
                              height: 35,
                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              child: new Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(5.0),
                                color: ColorValues.TEXT_COLOR,
                                child: MaterialButton(
                                    minWidth: 150,
                                    padding: EdgeInsets.fromLTRB(
                                        2.0, 2.0, 2.0, 2.0),
                                    onPressed: () {


                                      double price = double.tryParse(
                                          '${popularFood[index].price}');
                                      double total = double.tryParse(
                                          '${popularFood[index].quntity}') *
                                          double.tryParse(
                                              '${sizePrice}');
                                      DBProvider.db.FinalClient(
                                          '${popularFood[index].id}',
                                          popularFood[index].foodName,
                                          popularFood[index].size[0].size,
                                          '${popularFood[index].quntity}',
                                          '${price}',
                                          popularFood[index].discription,
                                          '0.0',
                                          '0.0',
                                          '0.0',
                                          '${popularFood[index].quntity}',
                                          '0.0',
                                          '0.0',
                                          '0.0',
                                          '0.0',
                                          '0.0',
                                          'organic',
                                          popularFood[index].photo,
                                          '${total}',
                                          '${price}',
                                          sizeId,
                                          sizeName,
                                          sizePrice
                                      );
                                      Fluttertoast.showToast(
                                        msg: Constant.ADD_TO_CART,
                                        toastLength: Toast.LENGTH_SHORT,
                                        //    gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        //  backgroundColor: Colors.red,
                                        //   textColor: Colors.white,
                                        //  fontSize: 16.0
                                      );

                                      Navigator.pop(context);


                                    },
                                    child: Text(
                                      "Add To Cart",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ColorValues.BACKGROUND,
                                        fontSize: 13.0,
                                        fontFamily: "customRegular",
                                      ),
                                    )),
                              ),
                            ),

                          ),

                          flex: 0,
                        ),


                      ],
                    ),
                  ),

                ),


              ],
            ),
          ),


        ),

        );

    });
    }


                                                      );
                                                },

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
                        onTap: () {
                         Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProductDescription(popularFood: popularFood[index])));

                        },
                      );

                    },
                    itemCount: popularFood.length,
                  )
              ),


            ],)
        ),
      ),
    );
  }
}