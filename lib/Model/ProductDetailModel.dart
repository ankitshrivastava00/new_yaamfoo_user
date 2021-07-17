class ProductDetailModel {

  String status;
  List<Data> msg;

  ProductDetailModel({this.status, this.msg});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['msg'] != null) {
      msg = new List<Data>();
      json['msg'].forEach((v) {
        msg.add(new Data.fromJson(v));
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

class Data {
  String id;
  String name;
  String weight;
  String unit;
  String price;
  String offerprice;
  String offerpercent;
  String description;
  String category;
  String quantity;
  String type;
  String modelName;
  String packof;
  String teaform;
  String flavor;
  String organic;
  String status;
  String modifydate;
  String addedDate;
  String addedBy;
  String updatedBy;
  String defaultImage;
  String moreGallryImages;

  Data({this.id,
    this.name,
    this.weight,
    this.unit,
    this.price,
    this.offerprice,
    this.offerpercent,
    this.description,
    this.category,
    this.quantity,
    this.type,
    this.modelName,
    this.packof,
    this.teaform,
    this.flavor,
    this.organic,
    this.status,
    this.modifydate,
    this.addedDate,
    this.addedBy,
    this.updatedBy,
    this.defaultImage,
    this.moreGallryImages});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    weight = json['weight'];
    unit = json['unit'];
    price = json['price'];
    offerprice = json['offerprice'];
    offerpercent = json['offerpercent'];
    description = json['description'];
    category = json['category'];
    quantity = json['quantity'];
    type = json['type'];
    modelName = json['modelName'];
    packof = json['packof'];
    teaform = json['teaform'];
    flavor = json['flavor'];
    organic = json['organic'];
    status = json['status'];
    modifydate = json['modifydate'];
    addedDate = json['added_date'];
    addedBy = json['added_by'];
    updatedBy = json['updated_by'];
    defaultImage = json['defaultImage'];
    moreGallryImages = json['moreGallryImages'];
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
    data['description'] = this.description;
    data['category'] = this.category;
    data['quantity'] = this.quantity;
    data['type'] = this.type;
    data['modelName'] = this.modelName;
    data['packof'] = this.packof;
    data['teaform'] = this.teaform;
    data['flavor'] = this.flavor;
    data['organic'] = this.organic;
    data['status'] = this.status;
    data['modifydate'] = this.modifydate;
    data['added_date'] = this.addedDate;
    data['added_by'] = this.addedBy;
    data['updated_by'] = this.updatedBy;
    data['defaultImage'] = this.defaultImage;
    data['moreGallryImages'] = this.moreGallryImages;
    return data;
  }
}