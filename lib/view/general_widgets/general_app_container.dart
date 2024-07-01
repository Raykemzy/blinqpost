import 'package:blinqpost/utils/colors.dart';
import 'package:blinqpost/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GeneralAppContainer extends ConsumerWidget {
  final double? width;
  final EdgeInsets? padding;
  final Widget child;
  final VoidCallback? onTap;
  const GeneralAppContainer({super.key, this.width, this.padding, required this.child, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.watch(appColorProvider);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? context.width,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: padding ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: appColor.borderColor),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
        ),
        child: child,
      ),
    );
  }
}