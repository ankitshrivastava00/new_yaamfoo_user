import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yaamfoo/constant/Padding_Wrap.dart';
import 'package:yaamfoo/drawer/screens/MyCart.dart';
import 'package:yaamfoo/drawer/screens/FavoriteList.dart';
import 'package:yaamfoo/drawer/screens/home.dart';
import 'package:yaamfoo/drawer/screens/profile.dart';
import 'package:yaamfoo/drawer/tabs/bottom_tabs.dart';
import 'package:yaamfoo/values/ColorValues.dart';

FavoriteList myFav = new FavoriteList();
MyCart myCart = new MyCart();

FavoriteState myFavState = FavoriteState();
MyCartState myCartMeState = MyCartState();

class TabsPage extends StatefulWidget {
  int selectedIndex = 0;

  TabsPage({this.selectedIndex,Key key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final _selectedItemColor = ColorValues.BACKGROUND;
  final _unselectedItemColor = ColorValues.TEXT_COLOR;
  final _selectedBgColor = ColorValues.TEXT_COLOR;
  final _unselectedBgColor = Colors.transparent;
  var count="0";
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Scaffold(
        body: IndexedStack(
          index: widget.selectedIndex,
          children: [
            for (final tabItem in TabNavigationItem.items) tabItem.page,
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _buildIcon('image/home.png', 'Home', 0),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: _buildIcon('image/favorite.png', 'Favorite', 1),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: _buildIconAddToCart('image/cart.png', 'Cart', 2),
            title: SizedBox.shrink(),
          ),

          BottomNavigationBarItem(
            icon: _buildIcon('image/user.png', 'Profile', 3),
            title: SizedBox.shrink(),
          ),
        ],
        currentIndex: widget.selectedIndex ,
        selectedItemColor: _selectedItemColor,
        unselectedItemColor: _unselectedItemColor,

        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,


      ),
    );
  }

  Widget _buildIconAddToCart(String iconData, String text, int index) => Container(
    width: 60.0,
    height: kBottomNavigationBarHeight,
    child: Material(
      color: _getBgColor(index),
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PaddingWrap.paddingfromLTRB(
                0.0,
                0.0,
                10.0,
                0.0,
                new Center(
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
                                child: Image.asset(iconData,width: 22.0,height: 22.0,color: _getItemColor(index)),
                        //  new Image.asset(iconData, color: Colors.white, width: 20.0),
                                width: 30.0,
                                height: 30.0,
                              ),
                              new Positioned(
                                  right: 0,
                                  top: 2 ,
                                  child: new Stack(
                                    children: <Widget>[
                                      new Icon(Icons.brightness_1,
                                          size:14.0,
                                          color: Colors.red[800]),
                                      new Positioned(
                                          top: 0.0,
                                          left: 0.0,
                                          right:0.0,
                                          bottom:0.0,
                                          child: new Center(
                                            child: new Text(
                                              "${count}",
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
                                                fontSize: 7.0,
                                              ),
                                            ),
                                          )),
                                    ],
                                  )),
                            ],
                          )),

                    )),

            // Image.asset(iconData,width: 22.0,height: 22.0,color: _getItemColor(index)),
            SizedBox(height: 5.0,),
            // Icon(iconData),
            Text(widget.selectedIndex  == index ?text:'',
                style: TextStyle(fontSize: 12, color: _getItemColor(index))),
          ],
        ),
        onTap: () => _onItemTapped(index),
      ),
    ),
  );

  Widget _buildIcon(String iconData, String text, int index) => Container(
    width: 60.0,
    height: kBottomNavigationBarHeight,
    child: Material(
      color: _getBgColor(index),
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(iconData,width: 22.0,height: 22.0,color: _getItemColor(index)),
            SizedBox(height: 5.0,),
            // Icon(iconData),
            Text(widget.selectedIndex  == index ?text:'',
                style: TextStyle(fontSize: 12, color: _getItemColor(index))),
          ],
        ),
        onTap: () => _onItemTapped(index),
      ),
    ),
  );

  void _onItemTapped(int index){
    setState(() {
      widget.selectedIndex  = index;
    });
  }
  Color _getBgColor(int index) =>
      widget.selectedIndex == index ? _selectedBgColor : _unselectedBgColor;

  Color _getItemColor(int index) =>
      widget.selectedIndex  == index ? _selectedItemColor : _unselectedItemColor;
  static List<TabNavigationItem> get items => [
    TabNavigationItem(
      page: Home(key: UniqueKey()),
      icon: Icon(Icons.home_filled),
      title: Text("Home"),
    ),
    TabNavigationItem(
      page: FavoriteList(key: UniqueKey()),
      icon: Icon(Icons.favorite),
      title: Text('Favorite'),
    ),
    TabNavigationItem(
      page: MyCart(key: UniqueKey()),
      icon: Icon(Icons.shopping_cart),
      title: Text('Cart'),
    ), TabNavigationItem(

      page: Profile(key: UniqueKey()),
      icon: Icon(Icons.person_rounded),
      title: Text('Profile'),
    ),
  ];
}
