import 'package:flutter/material.dart';
import 'package:project/logic/discounts_calculator.dart';
import 'package:project/logic/price_calculator.dart';
import 'package:project/models/discount_campaign.dart';
import 'package:project/models/shopping_item.dart';
import 'package:project/pages/discount_modal.dart';
import 'package:project/services/discount_campaign_service.dart';
import 'package:project/services/shopping_cart_service.dart';
import 'package:project/utils/color_utils.dart';
import 'package:project/utils/typo_utils.dart';
import 'package:project/widgets/discount_detail.dart';
import 'package:project/widgets/item_card.dart';
import 'package:project/widgets/price_detail.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage(
      {super.key,
      required this.shoppingCartService,
      required this.discountCampaignService});

  final ShoppingCartService shoppingCartService;
  final DiscountCampaignService discountCampaignService;

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  //State
  bool _isLoading = true;
  bool _usePoints = false;

  //Data
  List<ShoppingItem> _shoppingItems = [];
  List<DiscountCampaign> _discountCampaigns = [];
  SelectedDiscountCampaign _selectedDiscountCampaign =
      SelectedDiscountCampaign(null, null, null);

  late String _currency;

  double _totalPrice = 0;
  double _totalDiscounts = 0;
  final double _currentPoints = 1000; // assume that user have 1000 points
  double _availableDiscountPoints = 0;

  // Service
  DiscountCampaignService discountCampaignService = DiscountCampaignService();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    _shoppingItems = await widget.shoppingCartService.getShoppingCartItems();
    _discountCampaigns =
        await widget.discountCampaignService.getDiscountCampaigns();

    if (mounted) {
      _currency = _shoppingItems[0].currency;
      _totalPrice = getTotalPrice(_shoppingItems);
      _availableDiscountPoints =
          getAvailableDiscountPoints(_currentPoints, _totalPrice);

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> shoppingList =
        _shoppingItems.map((item) => ItemCard(item: item)).toList();

    showDiscountModal() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: AppColors.appBackground,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => DiscountCampaignModal(
            usePoints: _usePoints,
            totalPrice: _totalPrice,
            availableDiscountPoints: _availableDiscountPoints,
            currentPoints: _currentPoints,
            discountCampaigns: _discountCampaigns,
            shoppingItems: _shoppingItems,
            onSaveDiscounts: (total, usePoints, selectedDiscounts) {
              setState(() {
                _totalDiscounts = total;
                _usePoints = usePoints;
                _selectedDiscountCampaign = selectedDiscounts;
              });
            },
            selectedDiscounts: _selectedDiscountCampaign),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.all(10),
                height: double.infinity,
                width: double.infinity,
                child: Card(
                  color: AppColors.cardBackground,
                  child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                              spacing: 5,
                              children: [
                                const Icon(
                                  Icons.shopping_cart_outlined,
                                  color: AppColors.primaryFontColor,
                                  size: 20,
                                ),
                                AppFontUtils.createBoldBodyText('Order summary')
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: shoppingList,
                                ),
                              ),
                            ),
                          ),
                          const Divider(),
                          DiscountDetail(
                              showDiscountModal: showDiscountModal,
                              selectedDiscountCampaign:
                                  _selectedDiscountCampaign),
                          const Divider(),
                          const SizedBox(height: 5),
                          PriceDetail(
                              totalPrice: _totalPrice,
                              totalDiscounts: _totalDiscounts,
                              currency: _currency),
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: null,
                                style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    backgroundColor: AppColors.primaryBlue,
                                    fixedSize:
                                        const Size.fromWidth(double.infinity)),
                                child: AppFontUtils.createBoldBodyText(
                                    'Summary Price',
                                    color: Colors.white)),
                          )
                        ],
                      )),
                ),
              ),
      ),
    );
  }
}
