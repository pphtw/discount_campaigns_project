import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/models/shopping_item.dart';

class ShoppingCartService extends ChangeNotifier {
  Future<List<ShoppingItem>> getShoppingCartItems() async {
    final response =
        await rootBundle.loadString('assets/data/shopping_items.json');

    Map<String, dynamic> data = jsonDecode(response);
    List<ShoppingItem> shoppingItems = data['shopping_items']
        .map<ShoppingItem>((e) => ShoppingItem.fromJson(e as Map<String, dynamic>))
        .toList();

    return shoppingItems;
  }
}
