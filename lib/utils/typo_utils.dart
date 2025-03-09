import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project/utils/color_utils.dart';

final numberFormatter = NumberFormat('#,##,##0.00', 'th_TH');

class AppFontUtils {
  static createHeaderText(String text) {
    return Text(text,
        style: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ));
  }

  static createBodyText(String text, {textDecoration = TextDecoration.none}) {
    return Text(text,
        style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.secondaryFontColor,
            decoration: textDecoration));
  }

  static createBoldBodyText(String text,
      {Color color = AppColors.primaryFontColor,
      fontWeight = FontWeight.w600}) {
    return Text(text,
        style: GoogleFonts.inter(
          color: color,
          fontSize: 12,
          fontWeight: fontWeight,
        ));
  }
}
