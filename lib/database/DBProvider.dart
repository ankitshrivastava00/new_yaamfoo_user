import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yaamfoo/Model/Dbmodel.dart';
import 'package:yaamfoo/values/ColorValues.dart';


class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  Database _database;
  List<Dbmodel> _cart = [];


  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }


  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "yaamfoo.db");
    return await openDatabase(path, version: 1, onOpen: (db) {

    },
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Cart ("
              "id INTEGER PRIMARY KEY,"
              "product_id TEXT,"
              "product_name TEXT,"
              "weight TEXT,"
              "unit TEXT,"
              "price TEXT,"
              "description TEXT,"
              "offerprice TEXT,"
              "offerpercent TEXT,"
              "totalquantity TEXT,"
              "cartquantity TEXT,"
              "type TEXT,"
              "modelname TEXT,"
              "packof TEXT,"
              "teaform TEXT,"
              "flavor TEXT,"
              "organic TEXT,"
              "defaultImage TEXT,"
              "Total TEXT,"
              "Discount TEXT,"
              "sizeId TEXT,"
              "sizeName TEXT,"
              "sizePrice TEXT"

              ")");
          await db.execute("CREATE TABLE Extra ("
              "id INTEGER PRIMARY KEY,"
              "product_id TEXT,"
              "product_name TEXT,"
              "weight TEXT,"
              "unit TEXT,"
              "price TEXT,"
              "description TEXT,"
              "offerprice TEXT,"
              "offerpercent TEXT,"
              "totalquantity TEXT,"
              "cartquantity TEXT,"
              "type TEXT,"
              "modelname TEXT,"
              "packof TEXT,"
              "teaform TEXT,"
              "flavor TEXT,"
              "organic TEXT,"
              "defaultImage TEXT,"
              "Total TEXT,"
              "Discount TEXT,"
              "sizeId TEXT,"
              "sizeName TEXT,"
              "sizePrice TEXT"

              ")");
        });
  }

  FinalClient(String pro_id,
      String product_name,
      String weight,
      String unit,
      String price,
      String description,
      String offerprice,
      String offerpercent,
      String totalquantity,
      String cartquantity,
      String type,
      String modelname,
      String packof,
      String teaform,
      String flavor,
      String organic,
      String defaultImage,
      String Total,
      String Discount,
      String sizeId,
      String sizeName,
      String sizePrice


      ) async {
    final db = await database;
    var res = await db.query(
        "Cart", where: "product_id = ?", whereArgs: [pro_id]);
    return res.isNotEmpty ?
    updateClient(
        pro_id,
        product_name,
        weight,
        unit,
        price,
        description,
        offerprice,
        offerpercent,
        totalquantity,
        cartquantity,
        type,
        modelname,
        packof,
        teaform,
        flavor,
        organic,
        defaultImage,
        Total,
        Discount,
        sizeId,
         sizeName,
        sizePrice
    )

        :

    insertClient(
        pro_id,
        product_name,
        weight,
        unit,
        price,
        description,
        offerprice,
        offerpercent,
        totalquantity,
        cartquantity,
        type,
        modelname,
        packof,
        teaform,
        flavor,
        organic,
        defaultImage,
        Total,
        Discount,
        sizeId,
        sizeName,
        sizePrice
    )
    ;
  }

  insertClient(String pro_id,
      String product_name,
      String weight,
      String unit,
      String price,
      String description,
      String offerprice,
      String offerpercent,
      String totalquantity,
      String cartquantity,
      String type,
      String modelname,
      String packof,
      String teaform,
      String flavor,
      String organic,
      String defaultImage,
      String Total,
      String Discount,

      String sizeId,
      String sizeName,
      String sizePrice

      ) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Cart");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Cart (id,product_id,product_name,weight,unit,"
            "price,description,offerprice,offerpercent,totalquantity,cartquantity,type,modelname,packof,teaform,flavor,organic,defaultImage,Total,Discount,sizeId,sizeName,sizePrice )"
            " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
        [ id,
          pro_id,
          product_name,
          weight,
          unit,
          price,
          description,
          offerprice,
          offerpercent,
          totalquantity,
          cartquantity,
          type,
          modelname,
          packof,
          teaform,
          flavor,
          organic,
          defaultImage,
          Total,
          Discount,
          sizeId,
          sizeName,
          sizePrice
        ]);

    return raw;
  }

  getQuantity(String id) async{
    final db = await database;
    var res = await db.query("Cart", where: "product_id = ?", whereArgs: [id]);
    return res.toList();

  }
  getNoQuantity()async {
    var val="1";
        return val;
  }



  getClient(String id) async {
    final db = await database;
    var res = await db.query(
        "Cart", where: "product_id = ?", whereArgs: [id]);
    return res.isNotEmpty?getQuantity(id):null;
  }

  Future<List<Dbmodel>> getAllClients() async {
    final db = await database;
    var res = await db.query("Cart");
    List<Dbmodel> list =
    res.isNotEmpty ? res.map((c) => Dbmodel.fromMap(c)).toList() : [];
    return list;
  }


  getCount() async {
    var db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM Cart'));
  }

  getAllClientsCard() async {
    final db = await database;
    var res = await db.query("Cart");
    //   List<Client> list =
//    res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    print('casrdawf ${res.toList()}');

    return res.toList();
  }

  deleteClient(String id, String name) async {
    final db = await database;
   /* Fluttertoast.showToast(msg: "Item removed successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity:
        ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: ColorValues.SIGIN_TITLE_COLOR,
        textColor: Colors.white,
        fontSize: 16.0);*/
    return db.delete("Cart", where: "product_id = ? AND product_name = ?",
        whereArgs: [id, name]);
  }

  Future calculateTotal() async {
    final db = await database;
  //  var result = await db.rawQuery("SELECT SUM(Total) as Total FROM Cart");
    var result = await db.rawQuery("SELECT SUM(Total) as Total FROM Cart");
    print('totalmrp ${result.toList()}');
    return result.toList();
  }
  Future calculateSizePrice() async {
    final db = await database;
  //  var result = await db.rawQuery("SELECT SUM(Total) as Total FROM Cart");
    var result = await db.rawQuery("SELECT SUM(sizePrice) as sizePrice FROM Cart");
    print('totalmrp ${result.toList()}');
    return result.toList();
  }

  Future calculateQuantity() async {
    final db = await database;
    var result = await db.rawQuery("SELECT SUM(cartquantity) as cartquantity FROM Cart");
    print('totalcount ${result.toList()}');
    return result.toList();
  }

  Future calculateOfferTotal() async {
    final db = await database;
    var result = await db.rawQuery(
        "SELECT SUM(Discount) as Discount FROM Cart");
    print('totaldiscount ${result.toList()}');
    return result.toList();
  }

  // Cart Listing
  List<Dbmodel> get cartListing => _cart;

  deleteAll() async {
    final db = await database;
    db.rawDelete("DELETE FROM Cart");
  }


  updateClient(
      String pro_id,
      String product_name,
      String weight,
      String unit,
      String p_price,
      String description,
      String offerprice,
      String offerpercent,
      String totalquantity,
      String cartquantity,
      String type,
      String modelname,
      String packof,
      String teaform,
      String flavor,
      String organic,
      String defaultImage,
      String Total,
      String Discount,

  String sizeId,
      String sizeName,
      String sizePrice

      ) async {

     final db = await database;

     var res1 = await db.query("Cart", where: "product_id = ?", whereArgs: [pro_id]);

     String total = Dbmodel.fromMap(res1.first).total;
     String quant = Dbmodel.fromMap(res1.first).cartquantity;
     String dis = Dbmodel.fromMap(res1.first).discount;

   /*  double tabPrice = double.parse(total);
     double price = double.parse(p_price);
     double tbds = double.parse(dis);
     double discnt = double.parse(Discount);
     int quan = int.parse(quant);*/

        // print('RESPONCE_DATA : ' + totalp);


     var res =
     db.rawUpdate(
         "UPDATE Cart SET  cartquantity = '${cartquantity}',"
             "Total = '${Total}',"
             "sizeId = '${sizeId}',"
             "sizeName = '${sizeName}',"
             "sizePrice = '${sizePrice}',"

             "Discount = '${Discount}' WHERE product_id = '${pro_id}'");

/*

    Fluttertoast.showToast(msg: "Updated in the Cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: ColorValues.SIGIN_TITLE_COLOR,
        textColor: Colors.white,
        fontSize: 16.0);
*/

    return res;
  }


  FinalDecrement(String pro_id, String product_name, String product_price,
      String tablePrice,
      String tableQuan, String tabdis, String dis) async {
    final db = await database;
    var res = await db.query(
        "Cart", where: "product_id = ?", whereArgs: [pro_id]);
    int con = int.parse(Dbmodel
        .fromMap(res.first)
        .cartquantity);
    return con > 1 ?
    decrementClient(pro_id, product_price,
        tablePrice, tableQuan, tabdis, dis) :
    deleteClient(pro_id, product_name);
  }

  Mainincrement(String pro_id, product_price, String disco) async {
    final db = await database;
    var res = await db.query("Cart", where: "product_id = ?", whereArgs: [pro_id]);

    String total = Dbmodel.fromMap(res.first).total;
    String quant = Dbmodel.fromMap(res.first).cartquantity;
    String dis = Dbmodel.fromMap(res.first).discount;

    IncrementClient(pro_id, product_price, total, quant,dis,disco);
  }

  IncrementClient(String pro_id, product_price, String tablePrice,
      String tableQuan, String tabdis, String dis) async {
    final db = await database;
    double tabPrice = double.parse(tablePrice);
    double price = double.parse(product_price);
    double tbds = double.parse(tabdis);
    double discnt = double.parse(dis);
    int quan = int.parse(tableQuan);

    var res =
    db.rawUpdate(
        "UPDATE Cart SET  cartquantity = '${quan + 1}',"
            "Total = '${(tabPrice + price)}',"
            "Discount = '${(tbds + discnt)}' WHERE product_id = '${pro_id}'");

    //  db.rawUpdate("UPDATE Cart SET  cartquantity = '${(quan+1).toString()}',price = '${(tabPrice+price).toString()}' WHERE product_id = '${pro_id}'");
   /* Fluttertoast.showToast(msg: "Updated in the Cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity:
        ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: ColorValues.SIGIN_TITLE_COLOR,
        textColor: Colors.white,
        fontSize: 16.0);*/
    return res;
  }


  Maindecrement(String pro_id, product_price, String disco) async {
    final db = await database;
    var res = await db.query("Cart", where: "product_id = ?", whereArgs: [pro_id]);

    String total = Dbmodel.fromMap(res.first).total;
    String quant = Dbmodel.fromMap(res.first).cartquantity;
    String dis = Dbmodel.fromMap(res.first).discount;

    decrementClient(pro_id, product_price, total, quant,dis,disco);
  }


  decrementClient(String pro_id, product_price, String tablePrice,
      String tableQuan, String tabdis, String dis) async {
    final db = await database;
    double tabPrice = double.parse(tablePrice);
    double price = double.parse(product_price);
    double tbds = double.parse(tabdis);
    double discnt = double.parse(dis);
    int quan = int.parse(tableQuan);

    var res =
    db.rawUpdate(
        "UPDATE Cart SET  cartquantity = '${quan - 1}',Total = '${(tabPrice -
            price)}',Discount = '${(tbds -
            discnt)}' WHERE product_id = '${pro_id}'");

    //db.rawUpdate("UPDATE Cart SET  cartquantity = '${(quan-1).toString()}',price = '${(tabPrice-price).toString()}' WHERE product_id = '${pro_id}'");
  /*  Fluttertoast.showToast(msg: "Updated in the Cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity:
        ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: ColorValues.SIGIN_TITLE_COLOR,
        textColor: Colors.white,
        fontSize: 16.0);*/

    return res;
  }

}