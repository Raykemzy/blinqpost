import 'package:blinqpost/model/post_model.dart';
import 'package:blinqpost/utils/extensions.dart';
import 'package:blinqpost/view/general_widgets/general_app_container.dart';
import 'package:blinqpost/view/posts/widgets/image_loader.dart';
import 'package:blinqpost/view/posts/widgets/video_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

///This is the Super widget for items in the Post view.
///Subclasses would extend this widget to inherit it's properties
abstract class PostWidget extends StatefulWidget {
  final Post post;
  final VoidCallback likePost;
  final VoidCallback repost;
  const PostWidget({
    super.key,
    required this.post,
    required this.likePost,
    required this.repost,
  });

  ///Subclasses would override this method for custom content.
  ///Useful for when content is of different media type.
  Widget buildContent(BuildContext context);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return GeneralAppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.post.username,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              Text(timeago.format(widget.post.getDateTime)),
            ],
          ),
          10.verticalSpace,
          widget.buildContent(context),
          20.verticalSpace,
          Row(
            children: [
              InkWell(
                  onTap: widget.likePost,
                  child: switch (widget.post.likeCount > 0) {
                    true => Icon(
                        CupertinoIcons.heart_fill,
                        size: 20,
                        color: widget.post.likeCount > 0 ? Colors.red : null,
                      ),
                    _ => const Icon(CupertinoIcons.heart, size: 20),
                  }),
              5.horizontalSpace,
              Text(widget.post.likeCount.toString()),
              15.horizontalSpace,
              const Icon(CupertinoIcons.chat_bubble, size: 20),
              15.horizontalSpace,
              InkWell(
                onTap: widget.repost,
                child: Icon(
                  CupertinoIcons.repeat,
                  size: 20,
                  color: widget.post.isReposted ? Colors.green : null,
                ),
              ),
              5.horizontalSpace,
              Text(widget.post.repostCount.toString()),
            ],
          )
        ],
      ),
    );
  }
}

class TextPostContainer extends PostWidget {
  const TextPostContainer({
    super.key,
    required super.post,
    required super.likePost,
    required super.repost,
  });

  @override
  Widget buildContent(BuildContext context) {
    return Text(post.description);
  }
}

class ImagePostContainer extends PostWidget {
  const ImagePostContainer({
    super.key,
    required super.post,
    required super.likePost,
    required super.repost,
  });

  @override
  Widget buildContent(BuildContext context) {
    return SizedBox(
      height: 360.h,
      width: context.width,
      child: AppImageLoader(url: post.link, fit: BoxFit.cover),
    );
  }
}

class VideoPostContainer extends PostWidget {
  const VideoPostContainer({
    super.key,
    required super.post,
    required super.likePost,
    required super.repost,
  });

  @override
  Widget buildContent(BuildContext context) {
    return SizedBox(
        height: 360.h,
        width: context.width,
        child: VideoLoader(postId: post.id, videoUrl: post.link));
  }
}
