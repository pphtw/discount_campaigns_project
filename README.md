# Discount campaign Module

Contributor: Phutawan Palakavong

In this module, I assume that user have 1,000 points (You can find this constant in ShoppingCartPage.dart) and currency is THB.

shopping item data response example (shopping_items.json)
```
{
      "id": 2,
      "product": "Hat",
      "price": 250.00,
      "currency": "฿",
      "quantity": 1,
      "image_path": "assets/images/products/hat.jpg",
      "category": "accessories" // value: clothing, accessories, electronics
}
```
discount campaign data response example (discount_campaigns.json)
```
{
      "id": 3,
      "name": "Discount 15 % for clothing",
      "desc": "Discounts only clothing product by 15%.",
      "type": "percentageDiscountByItemCategory",
      "category": "onTop", // value: coupon, onTop, seasonal
      "amount": 15.0,
      "item_category": "clothing" // this attribute is optional (value: clothing, accessories, electronics)
}
```

### References
Products picture from https://www.freepik.com/
