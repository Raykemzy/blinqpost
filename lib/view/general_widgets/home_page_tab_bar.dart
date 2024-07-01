import 'package:blinqpost/utils/colors.dart';
import 'package:blinqpost/utils/enums.dart';
import 'package:flutter/material.dart';

class HomePageTabBar extends StatelessWidget {
  final BorderRadiusPosition radiusPosition; 
  final String text;
  const HomePageTabBar({super.key, required this.radiusPosition, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 40,
        // width: 250,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryDark, width: 2),
          borderRadius: switch (radiusPosition) {
            BorderRadiusPosition.left => const BorderRadius.horizontal(left: Radius.circular(10)),
            BorderRadiusPosition.right => const BorderRadius.horizontal(right: Radius.circular(15)),
          } 
        ),
        child: Text("data"),
      ),
    );
  }
}