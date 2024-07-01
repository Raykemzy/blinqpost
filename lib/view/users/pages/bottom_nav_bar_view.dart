import 'package:blinqpost/utils/enums.dart';
import 'package:blinqpost/view-model/post_view_model.dart';
import 'package:blinqpost/view/home_page.dart';
import 'package:blinqpost/view/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomNavBarView extends ConsumerStatefulWidget {
  const BottomNavBarView({super.key});

  @override
  ConsumerState<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends ConsumerState<BottomNavBarView> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  final pages = const [
    HomePage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (context, currentIndex, _) {
            return IndexedStack(
              index: currentIndex,
              children: [...pages],
            );
          }),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _currentIndex,
        builder: (context, currentIndex, _) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(172, 172, 172, 0.5),
                  blurRadius: 8,
                  offset: Offset(0, 0),
                  spreadRadius: -1,
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: _switchNavBarIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person),
                    label: "Profile",
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _switchNavBarIndex(int index) {
    BottomNavBarIndex? bottomNavBarIndex;
    switch (index) {
      case 0:
        bottomNavBarIndex = BottomNavBarIndex.posts;
        break;
      case 1:
        bottomNavBarIndex = BottomNavBarIndex.profile;
      default:
        bottomNavBarIndex = BottomNavBarIndex.posts;
    }

    _currentIndex.value = index;
    ref.read(postsProvider.notifier).switchNavBar(bottomNavBarIndex);
  }
}
