import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/pages/shopping_cart_page.dart';
import 'package:project/services/discount_campaign_service.dart';
import 'package:project/services/shopping_cart_service.dart';
import 'package:project/utils/color_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = true;
  final shoppingCartService = ShoppingCartService();
  final discountCampaignService = DiscountCampaignService();

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      shadowColor: Colors.transparent,
      // cardColor: AppColors.cardBackground,
      scaffoldBackgroundColor: AppColors.appBackground,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: ShoppingCartPage(
        shoppingCartService: shoppingCartService,
        discountCampaignService: discountCampaignService),
  ));
}
