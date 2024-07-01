import 'package:blinqpost/utils/colors.dart';
import 'package:blinqpost/view-model/theme_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.watch(appColorProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: appColor.borderColor,
                radius: 100,
                child: Icon(
                  CupertinoIcons.person,
                  size: 100,
                  color: appColor.profileIconColor,
                ),
              ),
              50.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Toggle Dark Mode"),
                  Consumer(
                    builder: (context, ref, _) {
                      return Switch.adaptive(
                        value: ref.watch(isDarkModeProvider),
                        onChanged: (v) {
                          final isDarkMode = ref.watch(isDarkModeProvider);
                          final notifier = ref.read(themeModeProvider.notifier);
                          isDarkMode
                              ? notifier.switchToLightMode()
                              : notifier.switchToDarkMode();
                        },
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
