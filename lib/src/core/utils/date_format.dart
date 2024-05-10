import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  final formatter = DateFormat('d MMMM yyyy');
  return formatter.format(dateTime);
}
