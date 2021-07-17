import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yaamfoo/drawer/screens/MyCart.dart';
import 'package:yaamfoo/drawer/screens/FavoriteList.dart';
import 'package:yaamfoo/drawer/screens/home.dart';
import 'package:yaamfoo/drawer/screens/profile.dart';
import 'package:yaamfoo/drawer/screens/search.dart';

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem({this.page, this.title, this.icon});

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
