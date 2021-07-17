import 'package:flutter/material.dart';
import 'package:yaamfoo/activity/order/OrderHistory.dart';
import 'package:yaamfoo/constant/Constant.dart';
import 'package:yaamfoo/constant/Padding_Wrap.dart';
import 'package:yaamfoo/drawer/screens/AboutUs.dart';
import 'package:yaamfoo/drawer/tabs/tabspage.dart';
import 'package:yaamfoo/values/ColorValues.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  SharedPreferences prefs;
  String _name,_email;
  var isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }
  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {

      _email=prefs.getString(Constant.USER_EMAIL);
      _name=prefs.getString(Constant.USER_NAME);
      isLoading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        //padding: EdgeInsets.zero,
        children: [

          isLoading? new CircularProgressIndicator(
            valueColor:AlwaysStoppedAnimation<Color>(ColorValues.TEXT_COLOR),

          ):
          // Profile Sharing
          PaddingWrap.paddingfromLTRB(
              18.0,
              20.0,
              0.0,
              0.0,
              new InkWell(
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        alignment: Alignment.center,
                       // margin: EdgeInsets.only(bottom:10.0),

                      //  padding: EdgeInsets.only(bottom:5.0),
                        child: Text(_name.isEmpty?'?':
                          '${_name[0].toUpperCase()}',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: ColorValues.TEXT_COLOR, fontSize: 25),
                        ),
                        decoration: BoxDecoration(

                          // color: Colors.yellow,
                            image: DecorationImage(
                                fit: BoxFit.cover, image: AssetImage('image/circle.png'))
                        ),
                        width: 50.0,
                        height: 50.0,

                      ),

                      new Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: /*new Text(
                          "My Address",
                          style: TextStyle(
                            fontFamily: 'customRegular',
                            fontSize: 16.0,
                            color: Color(ColorValues.HEADING_COLOR_EDUCATION),
                          ),
                        ),*/
                        new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            new Container(
                              margin: EdgeInsets.all(5.0),
                              alignment: Alignment.centerLeft,
                              child:
                              Text(_name,

                                style: TextStyle(
                                  color: ColorValues.TEXT_COLOR,
                                  fontSize: 15.0,

                                  fontFamily: "customSemiBold",

                                ),
                              ),
                            ),
                            new Container(
                              margin: EdgeInsets.all(5.0),
                              alignment: Alignment.centerLeft,
                              child:
                              Text(_email,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: ColorValues.TEXT_COLOR,
                                  fontSize: 12.0,
                                  fontFamily: "customRegular",

                                ),),)


                          ],
                        ),

                      )
                    ],
                  ),

                  )),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0.0),
            child: Divider(
              color: Colors.black45,
              height: 1.5,
            ),
          ),
          ListTile(
          
            leading:
            Image.asset('image/home.png',width: 20.0,height: 20.0),
            title: Text('Home',
              style: TextStyle(
                color: ColorValues.TEXT_COLOR,
                fontSize: 15.0,
                fontFamily: "customRegular",

              ),),
            onTap: () {
    Scaffold.of(context).openEndDrawer();

    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TabsPage(selectedIndex: 0)),
                );
            },
          ),
          ListTile(
            leading:
            Image.asset('image/order_history.png',width: 20.0,height: 20.0),

            title: Text('Your Order',
              style: TextStyle(
                color: ColorValues.TEXT_COLOR,
                fontSize: 15.0,
                fontFamily: "customRegular",

              ),),
            onTap: ()  {
    Scaffold.of(context).openEndDrawer();

    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderHistory()),
                );
            },
          ),
          ListTile(
            leading: Image.asset('image/favorite.png',width: 20.0,height: 20.0),
            title: Text('Favorite Order',
              style: TextStyle(
                color: ColorValues.TEXT_COLOR,
                fontSize: 15.0,
                fontFamily: "customRegular",

              ),),
            onTap: ()  {
              Scaffold.of(context).openEndDrawer();

              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TabsPage(selectedIndex: 1)),
                );
            },
          ),
          ListTile(
            leading: Image.asset('image/user.png',width: 20.0,height: 20.0),
            title: Text('Profile',
              style: TextStyle(
                color: ColorValues.TEXT_COLOR,
                fontSize: 15.0,
                fontFamily: "customRegular",

              ),),
            onTap: ()  {
              Scaffold.of(context).openEndDrawer();

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TabsPage(selectedIndex: 3)),
              );
            },
          ),
          ListTile(
            leading: Image.asset('image/about.png',width: 20.0,height: 20.0),
            title: Text('About',
              style: TextStyle(
                color: ColorValues.TEXT_COLOR,
                fontSize: 15.0,
                fontFamily: "customRegular",

              ),),
            onTap: () {
              Scaffold.of(context).openEndDrawer();

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUs()),
              );
            },
          ),
          
        ],
      ),
    );
  }
}