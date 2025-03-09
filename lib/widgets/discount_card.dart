import 'package:flutter/material.dart';
import 'package:project/models/discount_campaign.dart';
import 'package:project/utils/color_utils.dart';
import 'package:project/utils/typo_utils.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({super.key, required this.discountCampaign});

  final DiscountCampaign discountCampaign;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 5),
      color: AppColors.appBackground,
      shadowColor: Colors.transparent,
      child: Container(
        alignment: Alignment.centerLeft,
        height: 50,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(width: 5),
            AppFontUtils.createBoldBodyText(discountCampaign.name)
          ],
        ),
      ),
    );
  }
}
