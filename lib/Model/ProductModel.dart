class ProductModel {
  String status;
  List<Msg> msg;

  ProductModel({this.status, this.msg});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['msg'] != null) {
      msg = new List<Msg>();
      json['msg'].forEach((v) {
        msg.add(new Msg.fromJson(v));
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

class Msg {
  bool isSelected = false; //Selection property to highlight or not
  int itemCount = 0; //Selection property to highlight or not
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
  String starRate;


  Msg(
      {
        this.id,
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
        this.moreGallryImages,
        this.starRate

      });

  Msg.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    weight = json['weight'].toString();
    unit = json['unit'].toString();
    price = json['price'].toString();
    offerprice = json['offerprice'].toString();
    offerpercent = json['offerpercent'].toString();
    description = json['description'].toString();
    category = json['category'].toString();
    quantity = json['quantity'].toString();
    type = json['type'].toString();
    modelName = json['modelName'].toString();
    packof = json['packof'].toString();
    teaform = json['teaform'].toString();
    flavor = json['flavor'].toString();
    organic = json['organic'].toString();
    status = json['status'].toString();
    modifydate = json['modifydate'].toString();
    addedDate = json['added_date'].toString();
    addedBy = json['added_by'].toString();
    updatedBy = json['updated_by'].toString();
    defaultImage = json['defaultImage'].toString();
    moreGallryImages = json['GallryImages'].toString();
    starRate = json['starRate'].toString();
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
    data['GallryImages'] = this.moreGallryImages;
    data['starRate'] = this.starRate;
    return data;
  }
}
