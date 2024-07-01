import 'package:blinqpost/services/third_party_services/network_image_service.dart';
import 'package:blinqpost/services/third_party_services/shared_preferences_service.dart';
import 'package:blinqpost/utils/theme_config.dart';
import 'package:blinqpost/view-model/theme_notifier.dart';
import 'package:blinqpost/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NetworkImageService.initializeCachedNetworkImage();
  await SharedPreferenceService().init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      builder: (context, child) {
        return Consumer(
          builder: (context, ref, _) {
            final themeMode = ref.watch(themeModeProvider);
            return MaterialApp(
              themeMode: themeMode,
              theme: ThemeConfig.lightTheme,
              darkTheme: ThemeConfig.darkTheme,
              home: const SplashScreen(),
            );
          }
        );
      },
    );
  }
}
