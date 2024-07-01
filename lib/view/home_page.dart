import 'package:blinqpost/utils/colors.dart';
import 'package:blinqpost/view/posts/widgets/post_list.dart';
import 'package:blinqpost/view/users/widgets/users_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with TickerProviderStateMixin {
  late TabController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this)
      ..addListener(() {
        _updateIndex(_controller.index);
      });
  }

  void _updateIndex(int index) {
    _currentIndex = index;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColor = ref.watch(appColorProvider);
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: appColor.borderColor, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Theme(
                  data: theme.copyWith(
                    colorScheme: theme.colorScheme.copyWith(
                      surfaceVariant: Colors.transparent,
                    ),
                  ),
                  child: TabBar(
                    controller: _controller,
                    labelPadding: EdgeInsets.zero,
                    tabAlignment: TabAlignment.center,
                    indicatorColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: appColor.primaryColor,
                      borderRadius: switch (_currentIndex == 0) {
                        true => const BorderRadius.horizontal(left: Radius.circular(10)),
                        _ => const BorderRadius.horizontal(right: Radius.circular(10)),
                      },
                    ),
                    labelColor: appColor.selectedLabelColor,
                    unselectedLabelColor: appColor.unselectedLabelColor,
                    splashFactory: NoSplash.splashFactory,
                    tabs: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: Text("Posts"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: Text("Users"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: const [
                  PostList(),
                  UsersList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
