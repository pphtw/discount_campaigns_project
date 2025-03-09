import 'package:project/logic/price_calculator.dart';
import 'package:project/models/discount_campaign.dart';
import 'package:project/models/shopping_item.dart';

// fixed discount percentage of the total price in decimal format
const discountPointRate = 0.2; // 20%

getAvailableDiscountPoints(double currentPoints, double totalPrice) {
  double availableDiscountPoints = 0;
  if (currentPoints != 0) {
    final discountPoints = totalPrice * discountPointRate;
    if (discountPoints > currentPoints) {
      availableDiscountPoints = currentPoints;
    } else {
      availableDiscountPoints = discountPoints;
    }
  }

  return availableDiscountPoints;
}

getPercentageDiscount(double discountPercentRate, double totalPrice) {
  if (discountPercentRate > 1 || discountPercentRate < 0) {
    throw Exception(
        'the discount percent rate must be between 0 - 1: e.g. 20% - input is 0.2');
  }
  return discountPercentRate * totalPrice;
}

getDiscount(DiscountCampaign? selectedDiscount, totalPrice,
    {List<ShoppingItem>? shoppingItems}) {
  if (selectedDiscount == null) {
    return 0.0;
  } else {
    switch (selectedDiscount.type) {
      case DiscountCampaignType.fixedAmount:
        return selectedDiscount.amount;

      case DiscountCampaignType.percentageDiscount:
        return getPercentageDiscount(selectedDiscount.amount / 100, totalPrice);

      case DiscountCampaignType.percentageDiscountByItemCategory:
        if (shoppingItems == null) {
          throw Exception('must include shoppingItem');
        } else if (selectedDiscount.itemCategory == null) {
          throw Exception('must include itemCategory for discount');
        }
        double totalCategoryItemPrice = getPriceByItemCategory(
            shoppingItems, selectedDiscount.itemCategory!);
        return getPercentageDiscount(
            selectedDiscount.amount / 100, totalCategoryItemPrice);

      case DiscountCampaignType.specialCampaign:
        if (selectedDiscount.everyXBaht == null) {
          throw Exception("must include the every_x_baht amount");
        }
        int discountRound = (totalPrice / selectedDiscount.everyXBaht!).floor();
        return discountRound * selectedDiscount.amount;
    }
  }
  ;
}
