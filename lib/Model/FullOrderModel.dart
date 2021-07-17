class FullOrderModel {
  String status;
 // var data;
  List<OrderData> msg;

  FullOrderModel({this.status, this.msg});

  FullOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['msg'] != null) {
      msg = new List<OrderData>();
      json['msg']['productinfo'].forEach((v) {
        msg.add(new OrderData.fromJson(v));
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

class OrderData {
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
  String productRating;


  OrderData(
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
      this.defaultImage,
      this.productRating});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    weight = json['weight'];
    unit = json['unit'];
    price = json['price'];
    offerprice = json['offerprice'];
    offerpercent = json['offerpercent'];
    totalquantity = json['totalquantity'];
    cartquantity = json['orderquantity'];
    type = json['type'];
    modelName = json['modelName'];
    packof = json['packof'];
    teaform = json['teaform'];
    flavor = json['flavor'];
    organic = json['organic'];
    defaultImage = json['defaultImage'];
    productRating = json['productRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['weight'] = this.weight;
    data['unit'] = this.unit;
    data['price'] = this.price;
    data['offerprice'] = this.offerprice;
    data['offerpercent'] = this.offerpercent;
    data['totalquantity'] = this.totalquantity;
    data['orderquantity'] = this.cartquantity;
    data['type'] = this.type;
    data['modelName'] = this.modelName;
    data['packof'] = this.packof;
    data['teaform'] = this.teaform;
    data['flavor'] = this.flavor;
    data['organic'] = this.organic;
    data['defaultImage'] = this.defaultImage;
    data['productRating'] = this.productRating;
    return data;
  }

  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.cartquantity;
    return data;
  }
}
