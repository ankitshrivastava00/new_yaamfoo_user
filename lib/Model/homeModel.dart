class homeModel {
  Data data;
  int status;

  homeModel({this.data, this.status});

  homeModel.fromJson(Map<String, dynamic> json) {
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
  List<Category> category;
  List<Restaurant> restaurant;
  List<PopularFood> popularFood;

  Data({this.category, this.restaurant, this.popularFood});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = new List<Category>();
      json['category'].forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
    if (json['restaurant'] != null) {
      restaurant = new List<Restaurant>();
      json['restaurant'].forEach((v) {
        restaurant.add(new Restaurant.fromJson(v));
      });
    }
    if (json['popular_food'] != null) {
      popularFood = new List<PopularFood>();
      json['popular_food'].forEach((v) {
        popularFood.add(new PopularFood.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant.map((v) => v.toJson()).toList();
    }
    if (this.popularFood != null) {
      data['popular_food'] = this.popularFood.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int id;
  String categoryName;
  String image;

  Category({this.id, this.categoryName, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['image'] = this.image;
    return data;
  }
}

class Restaurant {
  int id;
  bool status;
  bool deleted;
  String createdAt;
  String updatedAt;
  String restaurantName;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String registrationNumber;
  String city;
  String state;
  String address;
  String pincode;
  String latitude;
  String longitude;
  String document;
  bool verified;
  int user;

  Restaurant(
      {this.id,
        this.status,
        this.deleted,
        this.createdAt,
        this.updatedAt,
        this.restaurantName,
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.email,
        this.registrationNumber,
        this.city,
        this.state,
        this.address,
        this.pincode,
        this.latitude,
        this.longitude,
        this.document,
        this.verified,
        this.user});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    restaurantName = json['restaurant_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    registrationNumber = json['registration_number'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
    pincode = json['pincode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    document = json['document'];
    verified = json['verified'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['deleted'] = this.deleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['restaurant_name'] = this.restaurantName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['registration_number'] = this.registrationNumber;
    data['city'] = this.city;
    data['state'] = this.state;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['document'] = this.document;
    data['verified'] = this.verified;
    data['user'] = this.user;
    return data;
  }
}

class PopularFood {
  int id;
  int quntity=1;
  String foodName;
  String price;
  String discription;
  String photo;
  String courseType;
  List<Size> size;
  List<SubItem> subItem;
  bool favorite;

  PopularFood(
      {this.id,
        this.quntity,
        this.foodName,
        this.price,
        this.discription,
        this.photo,
        this.courseType,
        this.size,
        this.subItem,
        this.favorite});

  PopularFood.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quntity = 1;
    foodName = json['food_name'];
    price = json['price'].toString();
    discription = json['discription'];
    photo = json['photo'];
    courseType = json['course_type'];
    if (json['size'] != null) {
      size = new List<Size>();
      json['size'].forEach((v) {
        size.add(new Size.fromJson(v));
      });
    }
    if (json['sub_item'] != null) {
      subItem = new List<SubItem>();
      json['sub_item'].forEach((v) {
        subItem.add(new SubItem.fromJson(v));
      });
    }
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
    if (this.size != null) {
      data['size'] = this.size.map((v) => v.toJson()).toList();
    }
    if (this.subItem != null) {
      data['sub_item'] = this.subItem.map((v) => v.toJson()).toList();
    }
    data['favorite'] = this.favorite;
    return data;
  }
}

class Size {
  int id;
  String size;
  bool isSelect=false;
  double price;
  String discription;

  Size({this.id, this.isSelect,this.size, this.price, this.discription});

  Size.fromJson(Map<String, dynamic> json) {
    isSelect = false;
    id = json['id'];
    size = json['size'];
    price = json['price'];
    discription = json['discription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    data['price'] = this.price;
    data['discription'] = this.discription;
    return data;
  }
}

class SubItem {
  int id;
  int subQuantity=0;
  String foodSubName;
  double price;
  String discription;

  SubItem({this.id,this.subQuantity, this.foodSubName, this.price, this.discription});

  SubItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subQuantity = 0;
    foodSubName = json['food_sub_name'];
    price = json['price'];
    discription = json['discription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['food_sub_name'] = this.foodSubName;
    data['price'] = this.price;
    data['discription'] = this.discription;
    return data;
  }
}