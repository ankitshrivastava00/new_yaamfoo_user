class SignUpModel {
  String status;
  SignUp msg;

  SignUpModel({this.status, this.msg});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'] != null ? new SignUp.fromJson(json['msg']) : null;
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

class SignUp {
  String name;
  String mobile;
  String email;
  int verify;
  String id;

  SignUp({this.name, this.mobile, this.email, this.verify, this.id});

  SignUp.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    verify = json['verify'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['verify'] = this.verify;
    data['id'] = this.id;
    return data;
  }
}