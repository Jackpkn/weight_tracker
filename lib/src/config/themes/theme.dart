import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get themeData {
    return ThemeData.dark().copyWith(
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.whiteColor, fontSize: 11),
        bodyMedium: TextStyle(color: AppColors.whiteColor, fontSize: 11),
      ),

      // Other theme data...
    );
  }
}
