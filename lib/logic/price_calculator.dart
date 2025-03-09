import 'package:project/models/shopping_item.dart';

getTotalPrice(List<ShoppingItem> shoppingItems) {
  final List<double> productPrices =
  shoppingItems.map((e) => e.totalItemPrice).toList();
  return productPrices.reduce((a, b) => a + b);
}

getPriceByItemCategory(
    List<ShoppingItem> shoppingItems, ProductCategory productCategory) {
  final filteredItems = shoppingItems
      .where((element) => productCategory == element.category)
      .toList();
  return getTotalPrice(filteredItems);
}
