import 'package:flutter/material.dart';
import 'package:yaamfoo/Model/Dbmodel.dart';
import 'package:yaamfoo/constant/Padding_Wrap.dart';
import 'package:yaamfoo/database/DBProvider.dart';
import 'package:yaamfoo/values/ColorValues.dart';

class OrderDetails extends StatefulWidget {
  @override
  OrderDetailsState createState() => OrderDetailsState();
}

class OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

backgroundColor: Colors.white,
appBar:      new AppBar(
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
            Navigator.pop(context);
            //  }
          },
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Order Details',
          style: new TextStyle(
              color: ColorValues.TEXT_COLOR,
              fontWeight: FontWeight.w600,
              fontFamily: "customRegular",
              fontSize: 18.0),
        ),
      ),

      body: new Container(

        child: new Stack(
          children: [
            Positioned(
              child: Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: new Image.asset('image/full_burger.png'),
              ),
              top: 0.0,
              left: 0.0,
            ),
            Positioned(
              child:
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0)),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                // color: Colors.white,
                child:

                          Container(
                            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                            //height: 800,
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
                                            "Veggie Burgers",
                                            style: new TextStyle(
                                                fontFamily: "customRegular",
                                                color: ColorValues.TEXT_COLOR,
                                                fontSize: 15),
                                          ),
                                          flex: 1,
                                        ),
                                        new Expanded(
                                          child: new Text(
                                            "₹ 15.00",
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
                                            "Spicy And Crispy With Garlic",
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
                                    child: new Row(
                                      children: [
                                        new Expanded(
                                          child: new Text(
                                            "12 May 2021   11:25 AM",
                                            style: new TextStyle(
                                                fontFamily: "customRegular",
                                                color: ColorValues.TEXT_COLOR,
                                                fontSize: 10),
                                          ),
                                          flex: 1,
                                        ),
                                        new Expanded(
                                          child:
                                          new Row(
                                            children: <Widget>[
                                                Image.asset(
                                                  'image/start.png',
                                                  height: 10.0,
                                                  width: 10.0,
                                                ),

                                                new Padding(
                                                  padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                                                  child: new Text(
                                                    "4.9 (105)",
                                                    style: TextStyle(
                                                        fontFamily: 'customLight',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 10.0,
                                                        color: Color(ColorValues.HEADING_COLOR_EDUCATION)),
                                                  ),
                                                ),


                                            ],
                                          ),
                                          flex: 0,
                                        )
                                      ],
                                    ),
                                  ),

                                ),
                                new Container(
                                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),

                                  height: 0.5,
                                  color: ColorValues.TIME_NOTITFICAITON,
                                ),


                                new Padding(
                                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                                  child: new Text(
                                    "Extra",
                                    style: TextStyle(
                                        fontFamily: 'customLight',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0,
                                        color: Color(ColorValues.HEADING_COLOR_EDUCATION)),
                                  ),
                                ),
                                PaddingWrap.paddingfromLTRB(
                                  10.0,
                                  10.0,
                                  0.0,
                                  0.0,
                                 new Row(
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
                                                  "Burger",
                                                  style: TextStyle(
                                                      fontFamily: 'customLight',

                                                      fontSize: 14.0,
                                                      color: Color(ColorValues.HEADING_COLOR_EDUCATION)),
                                                ),
                                              ),


                                            ],
                                          ),
                                          flex: 3,
                                        ),
                                        new Expanded(
                                          child: new Text(
                                            "₹ 5.00",
                                            style: new TextStyle(
                                                fontFamily: "customLight",
                                                color: ColorValues.YELLOW,
                                                fontSize: 14),
                                          ),
                                          flex: 7,
                                        )
                                      ],
                                    ),


                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 5.0),
                                  alignment: Alignment.centerLeft,
                                  child:
                                  Text('Delivery Address',

                                    style: TextStyle(
                                      color:ColorValues.TEXT_COLOR,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "customLight",
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                PaddingWrap.paddingfromLTRB(
                                    5.0,
                                    5.0,
                                    0.0,
                                    10.0,
                                    new InkWell(
                                      child:
                                      new Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child:  Image.asset(
                                              'image/shape.png',
                                              height: 15.0,
                                              width: 15.0,
                                              color: ColorValues.TEXT_COLOR,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 9,
                                            child:new Padding(
                                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
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

                                    )
                                ),

                                new Padding(
                                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                                  child: new Text(
                                    "Delivery Men",
                                    style: TextStyle(
                                        fontFamily: 'customLight',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0,
                                        color: Color(ColorValues.HEADING_COLOR_EDUCATION)),
                                  ),
                                ),
                                PaddingWrap.paddingfromLTRB(
                                    0.0,
                                    20.0,
                                    0.0,
                                    0.0,
                                    new InkWell(
                                      child: new Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child:  Image.asset(
                                              'image/profil_pic.png',
                                              height: 40.0,
                                              width: 40.0,
                                              // color: ColorValues.TEXT_COLOR,
                                            ),
                                          ),

                                          Expanded(
                                            flex: 8,
                                            child:new Padding(
                                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                                child:

                                                new Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    new Text(
                                                      "Harshad Patel",
                                                      style: TextStyle(
                                                          fontFamily: 'customLight',
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 13.0,
                                                          color: ColorValues.TEXT_COLOR),
                                                    ),
                                                    SizedBox(height: 6.0,),
                                                    new Text(
                                                      "Delivery Man",
                                                      style: TextStyle(
                                                          fontFamily: 'customLight',
                                                          fontSize: 12.0,
                                                          color: ColorValues.TEXT_COLOR),
                                                    ),
                                                  ],)

                                            ),
                                          ),
                                        ],
                                      ),

                                    )
                                ),
                              ],
                            ),
                          ),


                ),

              top: 160.0,
              right: 0.0,
              left: 0.0,
            ),

          ],
        ),
      ),

    );
  }
}


