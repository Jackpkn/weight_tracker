import 'package:flutter/material.dart';

class AppColors {
  static const Color focusedBorder = Colors.grey;
  static const Color borderColor = Colors.grey;
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
}

class AppBorders {
  static const BorderSide focusedBorder = BorderSide(
    color: AppColors.focusedBorder,
    width: 4,
  );
  static const BorderSide leftBorder = BorderSide(color: Colors.grey);
  static const BorderSide rightBorder = BorderSide(color: Colors.grey);
  static const BorderSide topBorder = BorderSide(color: Colors.grey);

  static Border get all {
    return const Border(
      bottom: focusedBorder,
      left: leftBorder,
      right: rightBorder,
      top: topBorder,
    );
  }
}
