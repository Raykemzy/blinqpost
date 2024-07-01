import 'package:blinqpost/model/user_model.dart';
import 'package:blinqpost/utils/enums.dart';
import 'package:blinqpost/view-model/user_view_model.dart';
import 'package:blinqpost/view/general_widgets/general_app_container.dart';
import 'package:blinqpost/view/users/widgets/user_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UsersList extends ConsumerStatefulWidget {
  const UsersList({super.key});

  @override
  ConsumerState<UsersList> createState() => _UsersListState();
}

class _UsersListState extends ConsumerState<UsersList> {
  final TextEditingController _controller = TextEditingController();
  List<User> searchedUsers = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(usersProvider.select((value) => value.users));
    final loadState = ref.watch(usersProvider.select((value) => value.loadState));

    if (loadState == LoadState.loading) {
      return const CupertinoActivityIndicator();
    }

    if (users.isEmpty) {
      return const Center(child: Text("No users found."));
    }

    if (_controller.text.isEmpty) {
      searchedUsers = users;
    }

    return Column(
      children: [
        GeneralAppContainer(
          child: Row(
            children: [
              const Icon(CupertinoIcons.search),
              10.horizontalSpace,
              Flexible(
                child: TextField(
                  controller: _controller,
                  onChanged: _searchUsers,
                  decoration: const InputDecoration(
                    hintText: "Search users...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        20.verticalSpace,
        Expanded(
          child: ListView.separated(
            itemCount: searchedUsers.length,
            separatorBuilder: (ctx, i) => SizedBox(height: 20.h),
            itemBuilder: (ctx, i) => UserTile(user: searchedUsers[i]),
          ),
        ),
      ],
    );
  }

  void _searchUsers(String query) {
    List<User> tempSearchedUsers = [];
    final users = ref.watch(usersProvider.select((value) => value.users));
    if (searchedUsers.isEmpty) {
      setState(() {
        searchedUsers = tempSearchedUsers;
      });
      return;
    }

    for (var user in users) {
      if (user.name.toLowerCase().contains(query) ||
          user.userName.toLowerCase().contains(query)) {
        tempSearchedUsers.add(user);
      }
    }

    setState(() {
      searchedUsers = tempSearchedUsers;
    });
  }
}
