import 'package:flutter/material.dart';
import 'package:project/utils/typo_utils.dart';

class PriceDetail extends StatelessWidget {
  const PriceDetail(
      {super.key,
      required this.totalPrice,
      required this.totalDiscounts,
      required this.currency});

  final double totalPrice;
  final double totalDiscounts;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppFontUtils.createBoldBodyText('Price Details'),
          const SizedBox(height: 5),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                AppFontUtils.createBodyText('Total Product Price'),
                AppFontUtils.createBoldBodyText(
                    '$currency ${numberFormatter.format(totalPrice)}',
                    fontWeight: FontWeight.w700),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                AppFontUtils.createBodyText('Total Discounts'),
                AppFontUtils.createBoldBodyText(
                    '$currency ${numberFormatter.format(totalDiscounts)}',
                    fontWeight: FontWeight.w700),
              ],
            ),
          ),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 5),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                AppFontUtils.createBoldBodyText('Total'),
                AppFontUtils.createBoldBodyText(
                    '$currency ${numberFormatter.format(totalPrice - totalDiscounts)}',
                    fontWeight: FontWeight.w700),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
