import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension BuildContextExt on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;
}

extension DateTimeExt on DateTime {
  String get toDateMonthYear => DateFormat('dd MMMM yyyy').format(this);
}
