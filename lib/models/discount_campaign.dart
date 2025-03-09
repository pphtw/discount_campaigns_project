import 'package:project/models/shopping_item.dart';

enum DiscountCampaignCategory {
  coupon('Coupon'),
  onTop('On Top'),
  seasonal('Seasonal');

  final String displayText;

  const DiscountCampaignCategory(this.displayText);
}

enum DiscountCampaignType {
  fixedAmount,
  percentageDiscount,
  percentageDiscountByItemCategory,
  specialCampaign
}

class DiscountCampaign {
  DiscountCampaign(this.id, this.name, this.type, this.category, this.amount,
      this.everyXBaht, this.itemCategory, this.desc,
      {this.isSelected = false});

  final int id;
  final String name;
  final String desc;
  final DiscountCampaignType type;
  final DiscountCampaignCategory category;
  final double amount;
  final double? everyXBaht;
  final ProductCategory? itemCategory;
  bool isSelected;

  factory DiscountCampaign.fromJson(Map<String, dynamic> json) {
    return DiscountCampaign(
        json['id'],
        json['name'],
        DiscountCampaignType.values.firstWhere(
          (element) => element.name == json['type'],
        ),
        DiscountCampaignCategory.values.firstWhere(
          (category) => category.name == json['category'],
        ),
        json['amount'],
        json['every_x_thb'],
        json['item_category'] == null
            ? null
            : ProductCategory.values.firstWhere(
                (category) => category.name == json['item_category']),
        json['desc']);
  }
}

class SelectedDiscountCampaign {
  DiscountCampaign? coupon;
  DiscountCampaign? onTop;
  DiscountCampaign? seasonal;

  SelectedDiscountCampaign(this.coupon, this.onTop, this.seasonal);

  getDiscountByCategory(DiscountCampaignCategory category) {
    switch (category) {
      case DiscountCampaignCategory.coupon:
        return coupon;
      case DiscountCampaignCategory.onTop:
        return onTop;
      case DiscountCampaignCategory.seasonal:
        return seasonal;
    }
  }

  int countNotNullAttributes() {
    int count = 0;
    if (coupon != null) count++;
    if (onTop != null) count++;
    if (seasonal != null) count++;
    return count;
  }
}
