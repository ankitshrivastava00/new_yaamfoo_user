import 'dart:io';

class BannerModel {
  String status;
  List<BannerImage> msg;

  BannerModel({this.status, this.msg});

  BannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['msg'] != null) {
      msg = new List<BannerImage>();
      json['msg'].forEach((v) {
        msg.add(new BannerImage.fromJson(v));
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

class BannerImage {
  String id;
  String image;
  String default1;
  String del;
  String bannerfor;
  String updatedDate;
  String updatedBy;

  BannerImage(
      {this.id,
      this.image,
      this.default1,
      this.del,
      this.bannerfor,
      this.updatedDate,
      this.updatedBy});

  BannerImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    default1 = json['default'];
    del = json['del'];
    bannerfor = json['bannerfor'];
    updatedDate = json['updated_date'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['default'] = this.default1;
    data['del'] = this.del;
    data['bannerfor'] = this.bannerfor;
    data['updated_date'] = this.updatedDate;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
