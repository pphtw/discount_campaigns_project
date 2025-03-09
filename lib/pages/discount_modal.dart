import 'package:flutter/material.dart';
import 'package:project/logic/discounts_calculator.dart';
import 'package:project/models/discount_campaign.dart';
import 'package:project/models/shopping_item.dart';
import 'package:project/utils/color_utils.dart';
import 'package:project/utils/typo_utils.dart';
import 'package:project/widgets/discount_radio_list_tile.dart';
import 'package:project/widgets/price_detail.dart';

class DiscountCampaignModal extends StatefulWidget {
  const DiscountCampaignModal(
      {super.key,
      required this.discountCampaigns,
      required this.currentPoints,
      required this.availableDiscountPoints,
      required this.totalPrice,
      required this.shoppingItems,
      required this.onSaveDiscounts,
      required this.usePoints,
      required this.selectedDiscounts});

  final List<ShoppingItem> shoppingItems;
  final List<DiscountCampaign> discountCampaigns;
  final double currentPoints;
  final double availableDiscountPoints;
  final double totalPrice;
  final Function(double, bool, SelectedDiscountCampaign) onSaveDiscounts;
  final bool usePoints;
  final SelectedDiscountCampaign selectedDiscounts;

  @override
  State<DiscountCampaignModal> createState() => _DiscountCampaignModalState();
}

class _DiscountCampaignModalState extends State<DiscountCampaignModal> {
  late bool _usePoints;
  double _totalDiscounts = 0.0;
  late SelectedDiscountCampaign _selectedDiscountCampaign;

  @override
  void initState() {
    _usePoints = widget.usePoints;
    _selectedDiscountCampaign = widget.selectedDiscounts;
    calculateDiscount();

    super.initState();
  }

  //calculate total discount and display to screen
  calculateDiscount() {
    setState(() {
      var pointsDiscount = _usePoints ? widget.availableDiscountPoints : 0;

      var couponDiscount =
          getDiscount(_selectedDiscountCampaign.coupon, widget.totalPrice);

      var onTopDiscount = _usePoints
          ? 0
          : getDiscount(_selectedDiscountCampaign.onTop, widget.totalPrice,
              shoppingItems: widget.shoppingItems);

      var seasonalDiscount =
          getDiscount(_selectedDiscountCampaign.seasonal, widget.totalPrice);

      _totalDiscounts =
          couponDiscount + onTopDiscount + seasonalDiscount + pointsDiscount;
    });
  }

  @override
  Widget build(BuildContext context) {
    onChangedCampaigns(selectedDiscount, category) {
      switch (category) {
        case DiscountCampaignCategory.coupon:
          _selectedDiscountCampaign.coupon = selectedDiscount;

        case DiscountCampaignCategory.onTop:
          _selectedDiscountCampaign.onTop = selectedDiscount;

        case DiscountCampaignCategory.seasonal:
          _selectedDiscountCampaign.seasonal = selectedDiscount;
      }
      calculateDiscount();
    }

    //discount campaign display
    List<Widget> listedCampaignsByCategory =
        DiscountCampaignCategory.values.map(
      (category) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppFontUtils.createBoldBodyText(category.displayText),
            const SizedBox(height: 5),
            SizedBox(
              child: SingleChildScrollView(
                child: DiscountRadioListTile(
                    selectedDiscount: _selectedDiscountCampaign
                        .getDiscountByCategory(category),
                    isDisable: _usePoints &&
                        category == DiscountCampaignCategory.onTop,
                    discountCampaigns: widget.discountCampaigns
                        .where((campaign) => campaign.category == category)
                        .toList(),
                    onChanged: (selectedDiscount) =>
                        onChangedCampaigns(selectedDiscount, category)),
              ),
            ),
            const Divider()
          ],
        );
      },
    ).toList();

    //point section display
    Widget pointDiscount = Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 2, color: AppColors.appBackground)),
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  AppFontUtils.createBoldBodyText('Your available points'),
                  AppFontUtils.createBoldBodyText(
                      '${numberFormatter.format(widget.currentPoints)} points'),
                ],
              )),
          const Divider(),
          SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppFontUtils.createBoldBodyText(
                          'Use ${widget.availableDiscountPoints} points for discount'),
                      AppFontUtils.createBodyText(
                          'Discount only 20% of total price'),
                    ],
                  ),
                  SizedBox(
                      height: 30,
                      child: FittedBox(
                        child: Switch(
                          value: _usePoints,
                          onChanged: (value) {
                            setState(() {
                              _usePoints = value;
                              calculateDiscount();
                            });
                          },
                        ),
                      )),
                ],
              )),
        ],
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 50),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppFontUtils.createBoldBodyText('Select your discounts'),
                      const SizedBox(height: 10),
                      pointDiscount,
                      const SizedBox(height: 10),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: listedCampaignsByCategory,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      PriceDetail(
                          totalPrice: widget.totalPrice,
                          totalDiscounts: _totalDiscounts,
                          currency: '฿'),
                    ]),
              ),
              Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          widget.onSaveDiscounts(_totalDiscounts, _usePoints,
                              _selectedDiscountCampaign);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            backgroundColor: AppColors.primaryBlue,
                            fixedSize: const Size.fromWidth(double.infinity)),
                        child: AppFontUtils.createBoldBodyText('Save',
                            color: Colors.white)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
