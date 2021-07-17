class AddressListModel {
  Data data;
  String error;
  int status;

  AddressListModel({this.data, this.error, this.status});

  AddressListModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    error = json['error'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['error'] = this.error;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  List<Address> address;
  int status;

  Data({this.address, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['address'] != null) {
      address = new List<Address>();
      json['address'].forEach((v) {
        address.add(new Address.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Address {
  int id;
  String city;
  String state;
  String address1;
  String address2;
  String postalCode;
  int user;

  Address(
      {this.id,
        this.city,
        this.state,
        this.address1,
        this.address2,
        this.postalCode,
        this.user});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    state = json['state'];
    address1 = json['address1'];
    address2 = json['address2'];
    postalCode = json['postal_code'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city'] = this.city;
    data['state'] = this.state;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['postal_code'] = this.postalCode;
    data['user'] = this.user;
    return data;
  }
}