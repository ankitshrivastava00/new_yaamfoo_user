class JsonObjectCustom {
  String id;
  String quantity;

  JsonObjectCustom(this.id, this.quantity);

  factory JsonObjectCustom.fromJson(dynamic json) {
    return JsonObjectCustom(json['id'] as String, json['quantity'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.quantity} }';
  }
}