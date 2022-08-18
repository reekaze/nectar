class Product {
  String? productId;
  String? name;
  String? price;
  String? unit;
  String? image;
  String? detail;
  String? type;
  String? tag;

  Product(
      {this.productId,
      this.name,
      this.price,
      this.unit,
      this.image,
      this.detail,
      this.type,
      this.tag});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        productId: json["productId"],
        name: json["name"],
        price: json["price"],
        unit: json["unit"],
        image: json["image"],
        detail: json["detail"] ?? "",
        type: json["type"],
        tag: json["tag"] ?? "");
  }
}
