enum ProductCategory { clothing, accessories, electronics }

class ShoppingItem {
  ShoppingItem(this.id, this.product, this.price, this.currency, this.quantity,
      this.imagePath, this.category);

  int id;
  String product;
  int quantity;
  double price;
  String currency;
  String imagePath;
  ProductCategory category;

  double get totalItemPrice {
    return quantity * price;
  }

  factory ShoppingItem.fromJson(Map<String, dynamic> json) {
    return ShoppingItem(
      json['id'],
      json['product'],
      json['price'],
      json['currency'],
      json['quantity'],
      json['image_path'],
      ProductCategory.values.firstWhere(
        (e) => e.name == json['category'],
      ),
    );
  }
}
