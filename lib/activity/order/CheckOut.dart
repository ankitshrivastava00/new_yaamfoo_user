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
import 'package:yaamfoo/Model/CartModel.dart';
import 'package:yaamfoo/Model/Dbmodel.dart';
import 'package:yaamfoo/Model/ProductModel.dart';
import 'package:yaamfoo/activity/ThankYou.dart';
import 'package:yaamfoo/comman/ApiConstant.dart';
import 'package:yaamfoo/comman/CustomProgressLoader.dart';
import 'package:yaamfoo/constant/Padding_Wrap.dart';
import 'package:yaamfoo/constant/Constant.dart';
import 'package:yaamfoo/database/DBProvider.dart';
import 'package:yaamfoo/drawer/tabs/tabspage.dart';
import 'package:yaamfoo/values/ColorValues.dart';
import 'package:http/http.dart';

class CheckOut extends StatefulWidget {
  String type = "";

  Msg _mData;
  SharedPreferences prefs;

  //MyCart(this.type, this._mData);

  static final String route = "Cart-route";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CheckOutState();
  }
}

class CheckOutState extends State<CheckOut> {
  String type = "";
  double carttotal = 0.0,
      offertotal = 0.0,
      discount_amount = 0.0,
      paid_amount = 0.0,
      con = 0.0;
 // Dbmodel item;
  String reply, coupan = "Promo Code";
  TextEditingController promocodeController = new TextEditingController();
  var product_name = new StringBuffer();
  var product_id = new StringBuffer();
  var price = new StringBuffer();
  var category = new StringBuffer();
  var quantity = new StringBuffer();
  var availablequantity = new StringBuffer();
  SharedPreferences prefs;
  List<Dbmodel> cart = [];
  double discount = 0.0, deliveryamount = 0.0, minimumamount = 0.0;
  String _name,_email,userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
    // setState(() => coupan = '${widget.code}');
    _calcTotal();
    setState(() {});
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {

      userId=prefs.getString(Constant.USER_ID);
      _email=prefs.getString(Constant.USER_EMAIL);
      _name=prefs.getString(Constant.USER_NAME);

    });
  }


/*
  void _calcTotal() async {
    var total = (await DBProvider.db.calculateTotal())[0]['Total'];
    var ofr = (await DBProvider.db.calculateOfferTotal())[0]['Discount'];
    // con = double.parse('${widget.price}');

    print('sdgfsfsdgsdfgsd ${total}');
    if (total != null) {
      setState(() => carttotal = total);
      setState(() => offertotal = ofr);
      setState(() => paid_amount = carttotal - offertotal + deliveryamount);
    } else {
      setState(() => carttotal = 0.0);
      setState(() => discount_amount = 0.0);
      setState(() => paid_amount = 0.0);
    }
  }
*/

  Future _calcTotal() async {
    //var total = (await DBProvider.db.calculateSizePrice())[0]['sizePrice'];
    var total = (await DBProvider.db.calculateTotal())[0]['Total'];
    // var ofr = (await DBProvider.db.calculateOfferTotal())[0]['Discount'];
    // con = double.parse('${widget.price}');

    print('sdgfsfsdgsdfgsd ${total}');
    if (total != null) {
      // setState(() => carttotal = ofr);
      setState(() => carttotal = total);
      //   setState(() => offertotal = ofr);
      // setState(() => paid_amount = carttotal - offertotal + deliveryamount);
    } else {
      setState(() => carttotal = 0.0);
      //   setState(() => discount_amount = 0.0);
      //  setState(() => paid_amount = 0.0);
    }
  }


  Future dltCoupan() async {
    var total = (await DBProvider.db.calculateTotal())[0]['Total'];
    setState(() => coupan = '');
    setState(() => carttotal = total);
    setState(() => paid_amount = carttotal);
    setState(() => con = 0.0);
  }

  showAlertDialog(BuildContext context, String id, String name) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Yes",
        style: TextStyle(color: ColorValues.SIGIN_TITLE_COLOR),
      ),
      onPressed: () {
        Navigator.pop(context);
        DBProvider.db.deleteClient(id, name);
        _calcTotal();
        setState(() {});
      },
    );

    Widget continueButton = FlatButton(
      child: Text(
        "No",
        style: TextStyle(color: ColorValues.SIGIN_TITLE_COLOR),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert !"),
      content: Text("Are you sure you want to remove this product from cart ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _submitTask() async{

        try {
          print("body+++++");
          CustomProgressLoader.showLoader(context);
          var url =Uri.parse(ApiConstant.CHECK_OUT);
          Map<String, String> headers = {"Content-type": "application/json"};

          var order = await DBProvider.db.getAllClients();

          List<Order> cart = new List();

          for (var i = 0; i < order.length; i++) {
            cart.add(new Order(
                food: '${order[i].product_id}',
                price: '${order[i].sizePrice}',
                food_type:  '${order[i].type}',
                food_name: '${order[i].product_name}',
                food_category: '${order[i].product_id}',
                food_course: '${order[i].type}',
                quantity: '${order[i].cartquantity}',
                size_price: '${order[i].sizePrice}',
                food_item_size: '${order[i].sizeId}',
                food_size: '${order[i].sizeName}',
                subItem: []
            ));
          }

          Map map = {
            "user": '${userId}',
            "restaurant": 1,
            "delivery_price":0.0,
            "discount_price":0.0,
            "cgst_price":12,
            "sgst_price":12,
            "igst_price":12,
            "final_price":carttotal,
            "city":"indore",
            "state":"MP",
            "pincode":123456,
            "address": "indore",
            "order_menu": cart.map((item) => item.toJson()).toList(),
          };

          // make POST request
          Response response =
          await post(url, headers: headers, body: json.encode(map));
          // check the status code for the result
          // this API passes back the id of the new item added to the body
          String body = response.body;
          CustomProgressLoader.cancelLoader(context);
          var data = json.decode(body);

          if (data['data']['status'].toString() == "201") {
            DBProvider.db.deleteAll();
            Fluttertoast.showToast(
                msg: "Order Placed Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              //  backgroundColor: ColorValues.SIGIN_TITLE_COLOR,
             //   textColor: Colors.white,
                fontSize: 16.0);

            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ThankYou()));

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
          CustomProgressLoader.cancelLoader(context);

        }
  }


  @override
  Widget build(BuildContext context) {
    Constant.applicationContext = context;

      return WillPopScope(
        onWillPop: () {

              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          TabsPage(selectedIndex: 2,)));
              },
        child: Scaffold(
        //  backgroundColor: Colors.white,
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

                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            TabsPage(selectedIndex: 2,)));              //  }
              },
            ),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Checkout',
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
                return

                  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
/*
                    Expanded(
                      flex: 0,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(
                            0.0, 5.0, 0.0, 5.0),
                        height: 80.0,
                        child:
                        new Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Expanded(
                              child: new Container(
                                  height: 80.0,
                                  width: 80.0,
                                  margin: const EdgeInsets.fromLTRB(
                                      10.0, 0.0, 10.0, 0.0),

                                  // color: Colors.transparent,

                                  child:
                                    Image.asset(
                                      'image/map.png',


                                  )),
                              flex: 0,
                            ),
                            new Expanded(
                              child:
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 0, 0, 0),
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
                                        0.0,
                                        0.0,
                                        0.0,
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                                          child: new Row(

                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              new Text(
                                                  "Deliver To",
                                                  style: new TextStyle(
                                                      fontFamily: "customRegular",
                                                      color: ColorValues.TEXT_COLOR,
                                                      fontSize: 12),
                                                ),
                                             new Container(
                                               margin: const EdgeInsets.fromLTRB(
                                                   0.0,0.0,20.0, 0.0),
                                               child:new Text(
                                                  "change",
                                                  style: new TextStyle(
                                                      fontFamily: "customRegular",
                                                      color: ColorValues.TEXT_COLOR,
                                                      fontSize: 12),
                                                ),
                                             ),
                                            ],
                                          ),
                                        ),

                                      ),
                                      new Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0.0,10, 0, 5.0),
                                        //  height: 120.0,
                                        //  width: 100.0,
                                        child:
                                        new Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 0,
                                              child:  Image.asset(
                                                'image/shape.png',
                                                height: 15.0,
                                                width: 15.0,
                                                color: ColorValues.TEXT_COLOR,
                                              ),
                                            ),
                                            Expanded(
                                              child:new Padding(
                                                padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                                                child: new Text(
                                                  "4140 Parker Rd. Allentown, New Mexico 31134",
                                                  style: TextStyle(
                                                      fontFamily: 'customLight',
                                                      //  fontWeight: FontWeight.w600,
                                                      fontSize: 11.0,
                                                      color: ColorValues.TEXT_COLOR),
                                                ),
                                              ),
                                            ),

                                          ],
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

                      ),
                    ),
*/
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.48,
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            // Dbmodel item = snapshot.data[index];
                            Dbmodel item = snapshot.data[index];
                            return new GestureDetector(
                              child:
                              Container(
                                margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
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
                                                    fit: BoxFit.fill, image: AssetImage('image/fav_back.png'))),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(0.0),
                                              child:
                                              Image.network(
                                              ApiConstant.IMAGE_BASE_URL+item.defaultImage,
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
                                                    item.product_name,
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
                                                            "₹ ${item.sizePrice}"+"  X  ${item.cartquantity}",
                                                            style: new TextStyle(
                                                                fontSize: 13.0,
                                                                color: ColorValues.TEXT_COLOR,
                                                                fontFamily:
                                                                "customLight")),
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
/*
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
                                                const EdgeInsets
                                                    .all(10.0),
                                                child: new Image.asset(
                                                  "image/delete.png",
                                                  width: 12.0,
                                                  height: 12.0,
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
                                                          "image/minus.png",
                                                          width: 15.0,
                                                          height: 15.0,
                                                        ),
                                                      ),
                                                      */
/*  onTap: () {
                                                        double dis = double
                                                            .parse(item
                                                            .price) -
                                                            double.parse(item
                                                                .offerprice);
                                                        if (item.cartquantity ==
                                                            "1") {
                                                          DBProvider.db.deleteClient(
                                                              item.product_id,
                                                              item.product_name);
                                                          _calcTotal();
                                                          setState(() {});
                                                        } else {
                                                          DBProvider.db.decrementClient(
                                                              item.product_id,
                                                              item.price,
                                                              item.total,
                                                              item.cartquantity,
                                                              item.discount,
                                                              dis.toString());
                                                          _calcTotal();
                                                        //  getDeliveryCharges();

                                                          setState(() {});
                                                        }


                                                      }*//*
),
                                                    new Text(
                                                      "1",
                                                      style: new TextStyle(
                                                          fontFamily:
                                                          "customBold",
                                                          fontSize: 13),
                                                    ),
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
                                                      */
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

                                                      }*//*
),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        flex: 0,
                                      ),
*/

                                    ],
                                  ),
                                ),
                              ),
                            );

                          },
                        ),
                      ),
                    ),

                      new Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: ColorValues.PAYMENT_OPTION_BACK,
                          borderRadius: BorderRadius.circular(30),),
                        margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                        padding: EdgeInsets.all(10.0),

                        child:
                        new InkWell(
                            child: new Row(
                              children: <Widget>[

                                Expanded(
                                  flex: 8,
                                  child:new Padding(
                                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                                    child: new Text(
                                      "Pay Via UPI / Wallet",
                                      style: TextStyle(
                                        fontFamily: 'customLight',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0,
                                        color: ColorValues.TEXT_COLOR,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex:2,
                                  child:
                                  Container(
                                    padding: EdgeInsets.all(2.0),


                                    child:
                                    Image.asset(
                                      'image/black_circle.png',
                                      height: 20.0,
                                      width: 20.0,
                                    ),                                ),
                                ),
                              ],
                            ),
                            onTap: () {

                            }
                        ),
                    ),
                    new Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: ColorValues.PAYMENT_OPTION_BACK,
                        borderRadius: BorderRadius.circular(30),),
                      margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                      padding: EdgeInsets.all(10.0),

                      child:
                      new InkWell(
                          child: new Row(
                            children: <Widget>[

                              Expanded(
                                flex: 8,
                                child:new Padding(
                                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                                  child: new Text(
                                    "Case On Delivery",
                                    style: TextStyle(
                                      fontFamily: 'customLight',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0,
                                      color: ColorValues.TEXT_COLOR,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex:2,
                                child:
                                Container(
                                  padding: EdgeInsets.all(2.0),


                                  child:
                                  Image.asset(
                                    'image/right_circle.png',
                                    height: 20.0,
                                    width: 20.0,
                                  ),                                ),
                              ),
                            ],
                          ),
                          onTap: () {

                          }
                      ),
                    ),

                    new Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5.0, 0, 5.0, 10),
                          child:  new Column(
                            children: [

                              new Container(
                                height: 40.0,
                                margin: EdgeInsets.fromLTRB(20.0,20.0,20.0,20.0),

                                child: Expanded(
                                  child:
                                  new InkWell(
                                    child: new Container(
                                      height: 40.0,
                                      color: Colors.transparent,
                                      child: new Container(
                                          decoration: new BoxDecoration(
                                              color: ColorValues.TEXT_COLOR,
                                              borderRadius: new BorderRadius.only(
                                                topLeft: const Radius.circular(10.0),
                                                topRight: const Radius.circular(10.0),
                                                bottomRight: const Radius.circular(10.0),
                                                bottomLeft: const Radius.circular(10.0),
                                              )),
                                          child: new Center(
                                            child:                   PaddingWrap.paddingfromLTRB(
                                                0.0,
                                                0.0,
                                                0.0,
                                                0.0,

                                                    new Padding(
                                                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                                      child: new Text(
                                                        "Confirm Order",
                                                        style: TextStyle(
                                                            fontFamily: 'customLight',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 12.0,
                                                            color: ColorValues.BACKGROUND
                                                        ),
                                                      ),
                                                    ),

                                            ),

                                          )),
                                    ),
                                    onTap: () {
                                      _submitTask();

                                    },
                                  ),
                                ),
                              ),

                            ],
                          ),

                        )),

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
