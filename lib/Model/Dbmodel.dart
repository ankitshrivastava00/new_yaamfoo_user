import 'dart:convert';

Dbmodel DbmodelFromJson(String str) {
  final jsonData = json.decode(str);
  return Dbmodel.fromMap(jsonData);
}

String DbmodelToJson(Dbmodel data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}



class Dbmodel {

  int id;
  String product_id;
  String product_name;
  String weight;
  String unit;
  String price;
  String description;
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
  String total;
  String discount;
  String sizeId;
  String sizeName;
  String sizePrice;


  Dbmodel({
    this.id,
    this.product_id,
    this.product_name,
    this.weight,
    this.unit,
    this.price,
    this.description,
    this.offerpercent,
    this.offerprice,
    this.totalquantity,
    this.cartquantity ,
    this.type ,
    this.modelName ,
    this.packof,
    this.teaform,
    this.flavor,
    this.organic,
    this.defaultImage,
    this.total,
    this.discount,
    this.sizeId,
    this.sizeName,
    this.sizePrice
  });


  factory Dbmodel.fromMap(Map<String, dynamic> json) => new Dbmodel(
    id: json["id"],
    product_id: json["product_id"],
    product_name: json["product_name"],
    weight: json["weight"],
    unit: json["unit"],
    price: json["price"],
    description: json["description"],
    offerprice: json["offerprice"],
    offerpercent: json["offerpercent"],
    totalquantity: json["totalquantity"],
    cartquantity: json["cartquantity"],
    type: json["type"],
    modelName: json["modelname"],
    packof: json["packof"],
    teaform: json["teaform"],
    flavor: json["flavor"],
    organic: json["organic"],
    defaultImage: json["defaultImage"],
    total: json["Total"],
    discount: json["Discount"],
    sizeId: json["sizeId"],
    sizeName: json["sizeName"],
    sizePrice: json["sizePrice"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "product_id": product_id,
    "product_name": product_name,
    "weight": weight,
    "unit": unit,
    "price": price,
    "description": description,
    "offerprice": offerprice,
    "offerpercent": offerpercent,
    "totalquantity": totalquantity,
    "cartquantity": cartquantity,
    "type": type,
    "modelname": modelName,
    "packof": packof,
    "teaform": teaform,
    "flavor": flavor,
    "organic": organic,
    "defaultImage": defaultImage,
    "Total": total,
    "Discount": discount,
    "sizeName": sizeName,
    "sizePrice": sizePrice,
    "sizeId": sizeId,
  };
}
