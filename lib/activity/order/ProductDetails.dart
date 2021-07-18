import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaamfoo/Model/Dbmodel.dart';
import 'package:yaamfoo/Model/SingleResturant.dart';
import 'package:yaamfoo/comman/ApiConstant.dart';
import 'package:yaamfoo/comman/CustomProgressLoader.dart';
import 'package:yaamfoo/constant/Constant.dart';
import 'package:yaamfoo/constant/Padding_Wrap.dart';
import 'package:yaamfoo/database/DBProvider.dart';
import 'package:yaamfoo/values/ColorValues.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

class ProductDetails extends StatefulWidget {
  String id;
  ProductDetails({this.id});
  @override
  ProductDetailsState createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetails> {

  SharedPreferences prefs;
  String rName,userId;
  String sizeId="",sizeName="",sizePrice="0.0";
  int rId;

  List<Category> category= new List();
  List<FoodItem> food_item= new List();
  SingleResturant _homeModel;
  var isLoading=false;
  productApi() async {
    // set up POST request arguments
    setState(() {
      isLoading=true;

    });

    try {
      print("body+++++");
      //  CustomProgressLoader.showLoader(context);
      var url =Uri.parse(ApiConstant.RESTURANT_SINGLE+widget.id);
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
        food_item = [];
        _homeModel = SingleResturant.fromJson(json.decode(body));


        setState(() {
          rName=_homeModel.data.restaurant.restaurantName;
          rId=_homeModel.data.restaurant.id;
          category.addAll(_homeModel.data.category);
          food_item.addAll(_homeModel.data.foodItem);
          setState(() {
            sizeId= '${food_item[0].size[0].id}';
            sizeName= food_item[0].size[0].size;
            sizePrice = '${food_item[0].size[0].price}';
            food_item[0].size[0].isSelect=true;

          });
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

    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) => productApi());
    }

  }


  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {

      userId=prefs.getString(Constant.USER_ID);


    });
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
          food_item[index].favorite=true;
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
  void deleteFavorite(foodId,userId,index) async{

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
          food_item[index].favorite=false;
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading?
      new Center(
          child:new CircularProgressIndicator(
            valueColor:AlwaysStoppedAnimation<Color>(ColorValues.TEXT_COLOR),

          )
      ):
      NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              leading: new InkWell(
                child:Container(
                  padding: EdgeInsets.all(20.0),
                  //  margin: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                  child: new Image.asset('image/back_arrow.png',
                    width: 10.0,
                    height:10,
                    color: Colors.white,

                  ),

                ),
                onTap: () {
                  /* if (widget.type == "home") {
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
                } else {*/
                  Navigator.pop(context);
                  //  }
                },
              ),

              title: Text('${rName}',style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontFamily: "customRegular",

              )),
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: new Stack(
                    children: [
                    Container(
                    height: 200.0,
                    width: MediaQuery.of(context).size.width,
          child:
          Image.asset(
          "image/full_burger.png",
          fit: BoxFit.fill,
          ),
          ),
                      Positioned(
                        child: Container(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                          height: 100.0,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
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
          "${rName}",
          style: new TextStyle(
          fontFamily: "customRegular",
          color: ColorValues.TEXT_COLOR,
          fontSize: 15),
          ),
          flex: 1,
          ),
          new Expanded(
          child: new Text(
          "Free Deliver",
          style: new TextStyle(
          fontFamily: "customRegular",
          color: ColorValues.CALL_COLOR,
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
          padding: EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
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
          padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
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
          "15 miles away",
          style: new TextStyle(
          fontFamily: "customLight",
          color: ColorValues.TEXT_COLOR,
          fontSize: 14),
          ),
          flex: 0,
          ),
          ],
          ),
          ),

          ),



                       ] ),
                        ),
                        ),
                        bottom:0.0,
                        left:20.0,
                        right:20.0,
                      ),

                    ],
                  ),
                  ),
            ),
          ];
        },
        body:
        FutureBuilder<List<Dbmodel>>(
          future: DBProvider.db.getAllClients(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Dbmodel>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 3.0),
                    alignment: Alignment.centerLeft,
                    child:
                    Text('Menu',

                      style: TextStyle(
                        color:ColorValues.TEXT_COLOR,
                        fontWeight: FontWeight.w600,
                        fontFamily: "customRegular",
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Container(

                      height: 40.0,
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
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
                                child:

                                Container(

                                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                                //  width: 100.0,
                                  height: 40.0,


                                  child: Card(

                                    elevation: 5.0,
                                    color:Colors.white,
                                    shape: RoundedRectangleBorder(

                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child:  Container(

                                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                   //   width: 100.0,
                                      height: 40.0,
                                      alignment: Alignment.center,


                                      child: Text('${category[index].categoryName}',
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
                            );
                        },
                        itemCount: category.length,
                      )
                  ),

/*
                  new Container(
                    height: 40.0,
                    margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                    child:
                  ListView(

                    // This next line does the trick.
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
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


                            child: Text('Pizza',
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


                    ],
                  ),
                  ),
*/
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.48,
                      child: ListView.builder(
                        itemCount:food_item.length,
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
                                EdgeInsets.fromLTRB(5.0,5.0, 5.0, 5.0),
                                child:
                                new Row(
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
                                            Image.network(ApiConstant.IMAGE_BASE_URL+food_item[index].photo,
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
                                                  food_item[index].foodName,
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
                                                new Text("spicy and crispy with garlic"
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
                                                          "₹ ${food_item[index].price}",
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
                                              child:  new GestureDetector(
                                                child:
                                                new Image.asset(food_item[index].favorite==true?"image/favorite.png":
                                                "image/heart_line.png",
                                                  width: 15.0,
                                                  height: 15.0,
                                                ),
                                                onTap: (){food_item[index].favorite==true?deleteFavorite(food_item[index].id,userId,index):
                                                  addFavorite(food_item[index].id,userId,index);
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
                                                    onTap: () {
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
                                                                                        food_item[index].foodName,
                                                                                        style: new TextStyle(
                                                                                            fontFamily: "customRegular",
                                                                                            color: ColorValues.TEXT_COLOR,
                                                                                            fontSize: 15),
                                                                                      ),
                                                                                      flex: 1,
                                                                                    ),
                                                                                    new Expanded(
                                                                                      child: new Text(

                                                                                        "₹ ${ food_item[index].price}",
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
                                                                                        food_item[index].foodName,
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
                                                                                          color:food_item[index].size[0].isSelect?ColorValues.TEXT_COLOR:Colors.white,
                                                                                          shape: RoundedRectangleBorder(

                                                                                            borderRadius: BorderRadius.circular(2),
                                                                                          ),
                                                                                          child:  Container(

                                                                                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                                                                            width: 100.0,
                                                                                            height: 40.0,
                                                                                            alignment: Alignment.center,


                                                                                            child: Text(
                                                                                              "${food_item[index].size[0].size}",
                                                                                              textAlign: TextAlign.center,
                                                                                              style: TextStyle(

                                                                                                color:food_item[index].size[0].isSelect?Colors.white:ColorValues.TEXT_COLOR,
                                                                                                fontFamily: "customLight",
                                                                                                fontSize: 13.0,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),

                                                                                        onTap: (){
                                                                                          setState(() {
                                                                                            sizeId= '${food_item[index].size[0].id}';
                                                                                            sizeName= food_item[index].size[0].size;
                                                                                            sizePrice = '${food_item[index].size[0].price}';
                                                                                            food_item[index].size[0].isSelect=true;
                                                                                            food_item[index].size[1].isSelect=false;

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
                                                                                          color:food_item[index].size[1].isSelect?ColorValues.TEXT_COLOR:Colors.white,
                                                                                          shape: RoundedRectangleBorder(

                                                                                            borderRadius: BorderRadius.circular(2),
                                                                                          ),
                                                                                          child:  Container(

                                                                                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                                                                            width: 100.0,
                                                                                            height: 40.0,
                                                                                            alignment: Alignment.center,


                                                                                            child: Text(
                                                                                              "${food_item[index].size[1].size}",
                                                                                              textAlign: TextAlign.center,
                                                                                              style: TextStyle(

                                                                                                color:food_item[index].size[1].isSelect?Colors.white:ColorValues.TEXT_COLOR,
                                                                                                fontFamily: "customLight",
                                                                                                fontSize: 13.0,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),

                                                                                        onTap: (){
                                                                                          setState(() {
                                                                                            sizeId= '${food_item[index].size[1].id}';
                                                                                            sizeName= food_item[index].size[1].size;
                                                                                            sizePrice = '${food_item[index].size[1].price}';

                                                                                            food_item[index].size[1].isSelect=true;
                                                                                            food_item[index].size[0].isSelect=false;

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
    for (var i = 0; i < food_item[index].size.length; i++) {

                                    if(subIndex==i){


                                      setState(() {
                                        sizeId= '${food_item[index].size[subIndex].id}';
                                        sizeName= food_item[index].size[subIndex].size;
                                        food_item[index].size[subIndex].isSelect=true;

                                      });

                                    }else{
                                      setState(() {
                                        food_item[index].size[subIndex].isSelect=false;


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
                                      color:  food_item[index].size[subIndex].isSelect? ColorValues.TEXT_COLOR:Colors.white,
                                      shape: RoundedRectangleBorder(

                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: Container(

                                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                        width: 100.0,
                                        height: 40.0,
                                        alignment: Alignment.center,


                                        child: Text(
                                          "${food_item[index].size[subIndex].size}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(

                                            color:  !food_item[index].size[subIndex].isSelect? ColorValues.TEXT_COLOR:Colors.white,
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
                          itemCount: food_item[index].size.length,
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
                                                food_item [index].subItem[extraIndex].foodSubName,
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
                                          "\$ ${food_item[index].subItem[extraIndex].price}",
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
                                                    if(food_item [index].subItem[extraIndex].subQuantity==0){

                                                    }else{
                                                      food_item [index].subItem[extraIndex].subQuantity--;

                                                    }

                                                  });
                                                },
                                              ),
                                              new Text(
                                                "${food_item [index].subItem[extraIndex].subQuantity}",
                                                style: new TextStyle(
                                                    fontFamily:
                                                    "customBold",
                                                    fontSize: 13),
                                              ),
                                              new InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    food_item [index].subItem[extraIndex].subQuantity++;

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
                          itemCount: food_item [index].subItem.length,
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
                                                                                            food_item[index].subItem[0].foodSubName,
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
                                                                                      "₹ ${food_item[index].subItem[0].price}",
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
                                                                                                if(food_item [index].subItem[0].subQuantity==0){

                                                                                                }else{
                                                                                                  food_item [index].subItem[0].subQuantity--;

                                                                                                }

                                                                                              });
                                                                                            },
                                                                                          ),
                                                                                          new Text(
                                                                                            "${food_item [index].subItem[0].subQuantity}",
                                                                                            style: new TextStyle(
                                                                                                fontFamily:
                                                                                                "customBold",
                                                                                                fontSize: 13),
                                                                                          ),
                                                                                          new InkWell(
                                                                                            onTap: (){
                                                                                              setState(() {
                                                                                                food_item [index].subItem[0].subQuantity++;

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
                                                                                            food_item[index].subItem[1].foodSubName,
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
                                                                                      "₹ ${food_item[index].subItem[1].price}",
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
                                                                                                if(food_item [index].subItem[1].subQuantity==0){

                                                                                                }else{
                                                                                                  food_item [index].subItem[1].subQuantity--;

                                                                                                }

                                                                                              });
                                                                                            },
                                                                                          ),
                                                                                          new Text(
                                                                                            "${food_item [index].subItem[1].subQuantity}",
                                                                                            style: new TextStyle(
                                                                                                fontFamily:
                                                                                                "customBold",
                                                                                                fontSize: 13),
                                                                                          ),
                                                                                          new InkWell(
                                                                                            onTap: (){
                                                                                              setState(() {
                                                                                                food_item [index].subItem[1].subQuantity++;

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
                                                                                        "₹ ${(double.tryParse('${food_item[index].quntity}') * double.tryParse('${sizePrice}'))+(double.tryParse('${food_item[index].subItem[0].price}')*double.tryParse('${food_item[index].subItem[0].subQuantity}'))+(double.tryParse('${food_item[index].subItem[1].price}')*double.tryParse('${food_item[index].subItem[1].subQuantity}'))}",
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
                                                                                                  (food_item[index].quntity == 1) {

                                                                                                  } else {
                                                                                                    setState(() {
                                                                                                      food_item[index].quntity--;
                                                                                                    });
                                                                                                  }
                                                                                                }


                                                                                            ),
                                                                                            new Text(
                                                                                              '${ food_item[index].quntity}',
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
                                                                                                    food_item[index].quntity++;
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
                                                                                                      '${food_item[index].price}');
                                                                                                  double total = double.tryParse(
                                                                                                      '${food_item[index].quntity}') *
                                                                                                      double.tryParse(
                                                                                                          '${sizePrice}');
                                                                                                  DBProvider.db.FinalClient(
                                                                                                      '${food_item[index].id}',
                                                                                                      food_item[index].foodName,
                                                                                                      food_item[index].size[0].size,
                                                                                                      '${food_item[index].quntity}',
                                                                                                      '${price}',
                                                                                                      food_item[index].discription,
                                                                                                      '0.0',
                                                                                                      '0.0',
                                                                                                      '0.0',
                                                                                                      '${food_item[index].quntity}',
                                                                                                      '0.0',
                                                                                                      '0.0',
                                                                                                      '0.0',
                                                                                                      '0.0',
                                                                                                      '0.0',
                                                                                                      'organic',
                                                                                                      food_item[index].photo,
                                                                                                      '${total}',
                                                                                                      '${price}',
                                                                                                      sizeId,
                                                                                                      sizeName,
                                                                                                      sizePrice
                                                                                                  );
                                                                                                  Navigator.pop(context);

                                                                                                  Fluttertoast.showToast(
                                                                                                    msg: Constant.ADD_TO_CART,
                                                                                                    toastLength: Toast.LENGTH_SHORT,
                                                                                                    //    gravity: ToastGravity.CENTER,
                                                                                                    timeInSecForIosWeb: 1,
                                                                                                    //  backgroundColor: Colors.red,
                                                                                                    //   textColor: Colors.white,
                                                                                                    //  fontSize: 16.0
                                                                                                  );
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
                                                      }),
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

                            },
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



      ),
    );


}
}