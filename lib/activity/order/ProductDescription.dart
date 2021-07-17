import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaamfoo/Model/Dbmodel.dart';
import 'package:yaamfoo/Model/SingleResturant.dart';
import 'package:yaamfoo/Model/homeModel.dart';
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

class ProductDescription extends StatefulWidget {
  String id;
  PopularFood popularFood;
  ProductDescription({this.popularFood});
  @override
  ProductDescriptionState createState() => ProductDescriptionState();
}

class ProductDescriptionState extends State<ProductDescription> {

  SharedPreferences prefs;
  String userId;
  String sizeId="",sizeName="",sizePrice="0.0";
  int rId;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }


  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {

      userId=prefs.getString(Constant.USER_ID);


    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      new AppBar(
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
          'Product Description',
          style: new TextStyle(
              color: ColorValues.TEXT_COLOR,
              fontWeight: FontWeight.w600,
              fontFamily: "customRegular",
              fontSize: 18.0),
        ),
      ),
        body:
SingleChildScrollView(child:

Container(
padding: EdgeInsets.all(10.0),
child:
Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 200.0,
                    width: MediaQuery.of(context).size.width,
                    child:
                    Image.asset(
                      "image/full_burger.png",
                    //  ApiConstant.IMAGE_BASE_URL+widget.popularFood.photo,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container (
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
                                      widget.popularFood.foodName,
                                      style: new TextStyle(
                                          fontFamily: "customRegular",
                                          color: ColorValues.TEXT_COLOR,
                                          fontSize: 15),
                                    ),
                                    flex: 1,
                                  ),
                                  new Expanded(
                                    child: new Text(

                                      "₹ ${ widget.popularFood.price}",
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
                                      widget.popularFood.discription,
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
                                        color:widget.popularFood.size[0].isSelect?ColorValues.TEXT_COLOR:Colors.white,
                                        shape: RoundedRectangleBorder(

                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                        child:  Container(

                                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                          width: 100.0,
                                          height: 40.0,
                                          alignment: Alignment.center,


                                          child: Text(
                                            "${widget.popularFood.size[0].size}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(

                                              color:widget.popularFood.size[0].isSelect?Colors.white:ColorValues.TEXT_COLOR,
                                              fontFamily: "customLight",
                                              fontSize: 13.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                      onTap: (){
                                        setState(() {
                                          sizeId= '${widget.popularFood.size[0].id}';
                                          sizeName= widget.popularFood.size[0].size;
                                          sizePrice = '${widget.popularFood.size[0].price}';
                                          widget.popularFood.size[0].isSelect=true;
                                          widget.popularFood.size[1].isSelect=false;

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
                                        color:widget.popularFood.size[1].isSelect?ColorValues.TEXT_COLOR:Colors.white,
                                        shape: RoundedRectangleBorder(

                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                        child:  Container(

                                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                          width: 100.0,
                                          height: 40.0,
                                          alignment: Alignment.center,


                                          child: Text(
                                            "${widget.popularFood.size[1].size}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(

                                              color:widget.popularFood.size[1].isSelect?Colors.white:ColorValues.TEXT_COLOR,
                                              fontFamily: "customLight",
                                              fontSize: 13.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                      onTap: (){
                                        setState(() {
                                          sizeId= '${widget.popularFood.size[1].id}';
                                          sizeName= widget.popularFood.size[1].size;
                                          sizePrice = '${widget.popularFood.size[1].price}';

                                          widget.popularFood.size[1].isSelect=true;
                                          widget.popularFood.size[0].isSelect=false;

                                        });

                                      },
                                    ), flex: 0,
                                  ),

                                ],
                              ),
                            ),

                          ),



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
                                          widget.popularFood.subItem[0].foodSubName,
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
                                    "₹ ${widget.popularFood.subItem[0].price}",
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
                                              if(widget.popularFood.subItem[0].subQuantity==0){

                                              }else{
                                                widget.popularFood.subItem[0].subQuantity--;

                                              }

                                            });
                                          },
                                        ),
                                        new Text(
                                          "${widget.popularFood.subItem[0].subQuantity}",
                                          style: new TextStyle(
                                              fontFamily:
                                              "customBold",
                                              fontSize: 13),
                                        ),
                                        new InkWell(
                                          onTap: (){
                                            setState(() {
                                              widget.popularFood.subItem[0].subQuantity++;

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
                                          widget.popularFood.subItem[1].foodSubName,
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
                                    "₹ ${widget.popularFood.subItem[1].price}",
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
                                              if(widget.popularFood.subItem[1].subQuantity==0){

                                              }else{
                                                widget.popularFood.subItem[1].subQuantity--;

                                              }

                                            });
                                          },
                                        ),
                                        new Text(
                                          "${widget.popularFood.subItem[1].subQuantity}",
                                          style: new TextStyle(
                                              fontFamily:
                                              "customBold",
                                              fontSize: 13),
                                        ),
                                        new InkWell(
                                          onTap: (){
                                            setState(() {
                                              widget.popularFood.subItem[1].subQuantity++;

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
                                      "₹ ${(double.tryParse(
                                          '${widget.popularFood.quntity}') *
                                          double.tryParse(
                                              '${sizePrice}'))}",
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
                                                (widget.popularFood.quntity == 1) {

                                                } else {
                                                  setState(() {
                                                    widget.popularFood.quntity--;
                                                  });
                                                }
                                              }


                                          ),
                                          new Text(
                                            '${ widget.popularFood.quntity}',
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
                                                  widget.popularFood.quntity++;
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
                                                    '${widget.popularFood.price}');
                                                double total = double.tryParse(
                                                    '${widget.popularFood.quntity}') *
                                                    double.tryParse(
                                                        '${sizePrice}');
                                                DBProvider.db.FinalClient(
                                                    '${widget.popularFood.id}',
                                                    widget.popularFood.foodName,
                                                    widget.popularFood.size[0].size,
                                                    '${widget.popularFood.quntity}',
                                                    '${price}',
                                                    widget.popularFood.discription,
                                                    '0.0',
                                                    '0.0',
                                                    '0.0',
                                                    '${widget.popularFood.quntity}',
                                                    '0.0',
                                                    '0.0',
                                                    '0.0',
                                                    '0.0',
                                                    '0.0',
                                                    'organic',
                                                    widget.popularFood.photo,
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


                ],
),
    ),
    ),





    );


  }
}