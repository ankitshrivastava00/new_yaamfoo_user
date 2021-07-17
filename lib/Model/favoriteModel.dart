class favoriteModel {
  Data data;
  int status;

  favoriteModel({this.data, this.status});

  favoriteModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  List<Favorite> favorite;
  int status;

  Data({this.favorite, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['favorite'] != null) {
      favorite = new List<Favorite>();
      json['favorite'].forEach((v) {
        favorite.add(new Favorite.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.favorite != null) {
      data['favorite'] = this.favorite.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Favorite {
  int id;
  Food food;

  Favorite({this.id, this.food});

  Favorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    food = json['food'] != null ? new Food.fromJson(json['food']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.food != null) {
      data['food'] = this.food.toJson();
    }
    return data;
  }
}

class Food {
  int id;
  String foodName;
  String price;
  String discription;
  String photo;
  String courseType;
  bool favorite;

  Food(
      {this.id,
        this.foodName,
        this.price,
        this.discription,
        this.photo,
        this.courseType,
        this.favorite});

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodName = json['food_name'];
    price = json['price'].toString();
    discription = json['discription'];
    photo = json['photo'];
    courseType = json['course_type'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['food_name'] = this.foodName;
    data['price'] = this.price;
    data['discription'] = this.discription;
    data['photo'] = this.photo;
    data['course_type'] = this.courseType;
    data['favorite'] = this.favorite;
    return data;
  }
}