import 'package:flutter/material.dart';
import 'package:weight_tracker/src/config/themes/app_colors.dart';

class AppStyle {
  static const fontSize = 12;

  static const userNoUserFound = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.red,
  );

  static const userNameTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static const weightStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
  );
  static const usernameC = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: AppColors.whiteColor,
  );
}

class AppCustomStyle {
  static const addScreenPadding =
      EdgeInsets.only(left: 3, right: 3, top: 10, bottom: 15);
  static const weightScreenPadding =
      EdgeInsets.only(left: 6, right: 6, top: 10);
  static const containerBorderRadius = BorderRadius.all(Radius.circular(10));
}
