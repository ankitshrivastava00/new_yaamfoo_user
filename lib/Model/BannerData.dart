import 'dart:io';

class BannerData {
  String status;
  List<Data> dataList;

  BannerData({this.status, this.dataList});

  BannerData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['msg'] != null) {
      dataList = new List<Data>();
      json['msg'].forEach((v) {
        dataList.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.dataList != null) {
      data['msg'] = this.dataList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String banner;
  String appbanner;
  String status;
  String addedate;

  Data({this.id, this.banner, this.appbanner, this.status, this.addedate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'];
    appbanner = json['appbanner'];
    status = json['status'];
    addedate = json['addedate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner'] = this.banner;
    data['appbanner'] = this.appbanner;
    data['status'] = this.status;
    data['addedate'] = this.addedate;
    return data;
  }
}

