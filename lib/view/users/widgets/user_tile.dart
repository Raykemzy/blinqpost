import 'package:blinqpost/model/user_model.dart';
import 'package:blinqpost/view/general_widgets/general_app_container.dart';
import 'package:blinqpost/view/posts/widgets/image_loader.dart';
import 'package:blinqpost/view/users/pages/user_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GeneralAppContainer(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserDetailPage(user: user)),
      ),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          AppImageLoader(
            url: user.photo ?? "",
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorWidget: const Icon(
              CupertinoIcons.exclamationmark_circle,
              color: Colors.red,
            ),
          ),
          10.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (user.userName.isNotEmpty)
                Text(
                  user.userName,
                  style: const TextStyle(fontSize: 12),
                ),
            ],
          )
        ],
      ),
    );
  }
}
