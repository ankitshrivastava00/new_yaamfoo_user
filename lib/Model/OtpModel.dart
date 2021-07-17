import 'dart:io';

class OtpModel {
  String status;
  OtpMod otp;

  OtpModel({this.status, this.otp});

  OtpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    otp = json['msg'] != null ? new OtpMod.fromJson(json['msg']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.otp != null) {
      data['msg'] = this.otp.toJson();
    }
    return data;
  }
}

class OtpMod {
  int otp;
  String mobile;

  OtpMod({this.otp, this.mobile});

  OtpMod.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['mobile'] = this.mobile;
    return data;
  }
}

