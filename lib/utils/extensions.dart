import 'package:blinqpost/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension BuildContextExt on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  void showSnackbar({required String text}) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.white),
      ),
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      backgroundColor: AppColors.primaryDark,
    );

    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  void hideSnackBar() => ScaffoldMessenger.of(this).hideCurrentSnackBar();
}

extension DateTimeExt on DateTime {
  String get toDateMonthYear => DateFormat('dd MMMM yyyy').format(this);
}
