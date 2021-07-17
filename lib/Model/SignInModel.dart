class SignInModel {
  String status;
  Sign msg;

  SignInModel({this.status, this.msg});

  SignInModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'] != null ? new Sign.fromJson(json['msg']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.msg != null) {
      data['msg'] = this.msg.toJson();
    }
    return data;
  }
}

class Sign {
  String mobile;
  String verify;
  String name;
  String email;
  String id;
  String notify;

  Sign({this.mobile, this.verify, this.id,this.email,this.name,this.notify});

  Sign.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'].toString();
    verify = json['verify'].toString();
    id = json['id'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
    notify = json['notify'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['verify'] = this.verify;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['notify'] = this.notify;
    return data;
  }
}