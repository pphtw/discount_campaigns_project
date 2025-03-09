import 'package:flutter/material.dart';
import 'package:project/models/shopping_item.dart';
import 'package:project/utils/typo_utils.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item});

  final ShoppingItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(image: AssetImage(item.imagePath))),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppFontUtils.createBoldBodyText(item.product),
                        AppFontUtils.createBodyText(item.category.name)
                      ],
                    ),
                  ),
                  AppFontUtils.createBodyText('x${item.quantity}'),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerRight,
                    width: 80,
                    child: AppFontUtils.createBoldBodyText(
                        '${item.currency} ${numberFormatter.format(item.totalItemPrice)}',
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
