import 'package:flutter/material.dart';
import 'package:vtu_topup/apps/core/constant/app_color.dart';

class TextStyleConstant {
  static const TextStyle heading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColor.textDark,
  );

  static const TextStyle subHeading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColor.textDark,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: AppColor.textDark,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColor.textLight,
  );

  static const subtext = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );
}