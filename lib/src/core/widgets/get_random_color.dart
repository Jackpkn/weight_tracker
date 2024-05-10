import 'dart:math';

import 'package:flutter/material.dart';

Color getRandomPredefinedColor() {
  final random = Random();
  const predefinedColors = Colors.primaries;
  return predefinedColors[random.nextInt(predefinedColors.length)];
}
