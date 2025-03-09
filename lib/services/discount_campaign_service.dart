import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/models/discount_campaign.dart';

class DiscountCampaignService extends ChangeNotifier {
  Future<List<DiscountCampaign>> getDiscountCampaigns() async {
    final response =
        await rootBundle.loadString('assets/data/discount_campaigns.json');

    Map<String, dynamic> data = jsonDecode(response);
    List<DiscountCampaign> shoppingItems = data['discount_campaigns']
        .map<DiscountCampaign>(
            (e) => DiscountCampaign.fromJson(e as Map<String, dynamic>))
        .toList();

    return shoppingItems;
  }
}
