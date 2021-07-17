class CartModel {
  List<Order> order;

  CartModel({this.order});

  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['order'] != null) {
      order = new List<Order>();
      json['order'].forEach((v) {
        order.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Order {
  String price;
  String food;
  String food_type;
  String food_name;
  String food_category;
  String food_course;
  String quantity;
  String size_price;
  String food_item_size;
  String food_size;
  List<SubItem> subItem;

  Order(
      {this.price,
        this.food,
        this.food_type,
        this.food_name,
        this.food_category,
        this.food_course,
        this.quantity,
        this.size_price,
        this.food_item_size,
        this.food_size,
        this.subItem});

  Order.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    food = json['food'];
    food_type = json['food_type'];
    food_name = json['food_name'];
    food_category = json['food_category'];
    food_course = json['food_course'];
    quantity = json['quantity'];
    size_price = json['size_price'];
    food_item_size = json['food_item_size'];
    food_size = json['food_size'];
    if (json['sub_item'] != null) {
      subItem = new List<SubItem>();
      json['sub_item'].forEach((v) {
        subItem.add(new SubItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['food'] = this.food;
    data['food_type'] = this.food_type;
    data['food_name'] = this.food_name;
    data['food_category'] = this.food_category;
    data['food_course'] = this.food_course;
    data['quantity'] = this.quantity;
    data['size_price'] = this.size_price;
    data['food_item_size'] = this.food_item_size;
    data['food_size'] = this.food_size;
    if (this.subItem != null) {
      data['sub_item'] = this.subItem.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubItem {
  String id;
  String price;

  SubItem({this.id, this.price});

  SubItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    return data;
  }
}

/*
class CartModel {
  String status;
  var data;
  List<CartData> msg;

  CartModel({this.status, this.msg});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['msg'] != null) {
      msg = new List<CartData>();
      json['msg'].forEach((v) {
        msg.add(new CartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.msg != null) {
      data['msg'] = this.msg.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartData {
  String id;
  String name;
  String weight;
  String unit;
  String price;
  String offerprice;
  String offerpercent;
  String totalquantity;
  String cartquantity;
  String type;
  String modelName;
  String packof;
  String teaform;
  String flavor;
  String organic;
  String defaultImage;

  CartData(
      {this.id,
      this.name,
      this.weight,
      this.unit,
      this.price,
      this.offerprice,
      this.offerpercent,
      this.totalquantity,
      this.cartquantity,
      this.type,
      this.modelName,
      this.packof,
      this.teaform,
      this.flavor,
      this.organic,
      this.defaultImage});

  CartData.fromJson(Map<String, dynamic> json) {
    id = json["product_id"];
    name = json["product_name"];
    weight = json["weight"];
    unit = json["unit"];
    price = json["price"];
    offerprice = json["offerprice"];
    offerpercent = json["offerpercent"];
    totalquantity = json["totalquantity"];
    cartquantity = json["cartquantity"];
    type = json["type"];
    modelName = json["modelName"];
    packof = json["packof"];
    teaform = json["teaform"];
    flavor = json["flavor"];
    organic = json["organic"];
    defaultImage = json["defaultImage"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["product_id"] = this.id;
    data["product_name"] = this.name;
    data["weight"] = this.weight;
    data["unit"] = this.unit;
    data["price"] = this.price;
    data["offerprice"] = this.offerprice;
    data["offerpercent"] = this.offerpercent;
    data["totalquantity"] = this.totalquantity;
    data["cartquantity"] = this.cartquantity;
    data["type"] = this.type;
    data["modelName"] = this.modelName;
    data["packof"] = this.packof;
    data["teaform"] = this.teaform;
    data["flavor"] = this.flavor;
    data["organic"] = this.organic;
    data["defaultImage"] = this.defaultImage;
    return data;
  }

  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["quantity"] = this.cartquantity;

    return data;
  }
}
*/
