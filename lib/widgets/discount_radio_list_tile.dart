import 'package:flutter/material.dart';
import 'package:project/models/discount_campaign.dart';
import 'package:project/utils/typo_utils.dart';

class DiscountRadioListTile extends StatefulWidget {
  const DiscountRadioListTile(
      {super.key,
      required this.discountCampaigns,
      required this.isDisable,
      required this.onChanged,
      this.selectedDiscount});

  final List<DiscountCampaign> discountCampaigns;
  final bool isDisable;
  final Function(DiscountCampaign?) onChanged;
  final DiscountCampaign? selectedDiscount;

  @override
  State<DiscountRadioListTile> createState() => _DiscountRadioListTileState();
}

class _DiscountRadioListTileState extends State<DiscountRadioListTile> {
  DiscountCampaign? _selectedDiscount;

  @override
  void initState() {
    super.initState();
    _selectedDiscount = widget.selectedDiscount;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.discountCampaigns.map((discountCampaign) {
        return RadioListTile(
            subtitle: AppFontUtils.createBodyText(discountCampaign.desc),
            title: AppFontUtils.createBoldBodyText(discountCampaign.name),
            value: discountCampaign,
            groupValue: widget.isDisable ? null : _selectedDiscount,
            toggleable: true,
            onChanged: widget.isDisable
                ? null
                : (value) {
                    setState(() {
                      _selectedDiscount = value as DiscountCampaign?;
                      widget.onChanged(_selectedDiscount);
                    });
                  });
      }).toList(),
    );
  }
}
