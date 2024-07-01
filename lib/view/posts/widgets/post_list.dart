import 'package:blinqpost/model/post_model.dart';
import 'package:blinqpost/utils/enums.dart';
import 'package:blinqpost/view-model/post_view_model.dart';
import 'package:blinqpost/view/posts/widgets/post_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostList extends ConsumerWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postsProvider.select((value) => value.posts));
    final loadState = ref.watch(postsProvider.select((value) => value.loadState));

    if (loadState == LoadState.loading) {
      return const CupertinoActivityIndicator();
    }

    if (posts.isEmpty) {
      return const Center(child: Text("No posts available."));
    }

    return ListView.separated(
      itemCount: posts.length,
      separatorBuilder: (ctx, i) => SizedBox(height: 20.h),
      itemBuilder: (ctx, i) => _getPostWidget(
        posts[i],
        () => ref.read(postsProvider.notifier).likePost(posts[i].id),
      ),
    );
  }

  Widget _getPostWidget(Post post, VoidCallback likePost) {
    PostWidget? postWidget;
    if (post.isText) {
      postWidget = TextPostContainer(post: post, likePost: likePost);
    } else if (post.isImage) {
      postWidget = ImagePostContainer(post: post, likePost: likePost);
    } else {
      postWidget = VideoPostContainer(post: post, likePost: likePost);
    }
    return postWidget;
  }
}
