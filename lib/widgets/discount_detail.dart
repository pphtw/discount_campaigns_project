import 'package:flutter/material.dart';
import 'package:project/models/discount_campaign.dart';
import 'package:project/utils/typo_utils.dart';

class DiscountDetail extends StatelessWidget {
  const DiscountDetail(
      {super.key,
      required this.selectedDiscountCampaign,
      required this.showDiscountModal});

  final SelectedDiscountCampaign selectedDiscountCampaign;
  final Function() showDiscountModal;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppFontUtils.createBoldBodyText('Discount details'),
            const SizedBox(height: 5),
            SizedBox(
              height: 30,
              width: double.infinity,
              child: TextButton(
                  style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      padding: const EdgeInsets.all(0),
                      fixedSize: const Size.fromWidth(double.infinity)),
                  onPressed: showDiscountModal,
                  child: SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        AppFontUtils.createBodyText('Select discounts',
                            textDecoration: TextDecoration.underline),
                        AppFontUtils.createBoldBodyText(
                            '${selectedDiscountCampaign.countNotNullAttributes()} selected')
                      ],
                    ),
                  )),
            )
          ],
        ));
  }
}
