import 'package:flutter/material.dart';

Color getMonthColor(int monthIndex) {
  switch (monthIndex) {
    case 1:
      return Colors.green;
    case 2:
      return Colors.orange;
    case 3:
      return Colors.blue;
    case 4:
      return Colors.purple;
    case 5:
      return Colors.pink;
    case 6:
      return Colors.brown;
    case 7:
      return Colors.teal;
    case 8:
      return Colors.indigo;
    case 9:
      return Colors.lime;
    case 10:
      return Colors.cyan;
    case 11:
      return Colors.amber;
    case 12:
      return Colors.deepOrange;
    default:
      return Colors.grey;
  }
}

String getMonthLabel(int monthIndex) {
  switch (monthIndex) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Aug';
    case 9:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
    default:
      return '';
  }
}
