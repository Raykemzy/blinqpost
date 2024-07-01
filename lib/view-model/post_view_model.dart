import 'package:blinqpost/model/post_model.dart';
import 'package:blinqpost/services/firestore_service.dart';
import 'package:blinqpost/utils/enums.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostNotifier extends AutoDisposeNotifier<PostState> {
  late FireStoreService _service;

  @override
  PostState build() {
    _service = ref.read(remoteStorageProvider);
    fetchPosts();
    return PostState.initial();
  }

  void switchNavBar(BottomNavBarIndex index) {
    state = state.copyWith(navBarIndex: index);
  }

  void fetchPosts() async {
    try {
      final response = await _service.getPosts();
      if (response.success == false) throw Exception(response.message);
      state = state.copyWith(
        posts: response.data,
        loadState: LoadState.success,
      );
    } catch (e) {
      state = state.copyWith(loadState: LoadState.error);
    }
  }

  void likePost(String postId) {
    try {
      final postIndex = state.posts.indexWhere((post) => post.id == postId);
      if (postIndex >= 0) {
        final post = state.posts[postIndex];
        final updatedPost = post.copyWith(
          likeCount: post.isLiked ? post.likeCount - 1 : post.likeCount + 1,
          isLiked: !post.isLiked,
        );

        final updatedPosts = List<Post>.from(state.posts);
        updatedPosts[postIndex] = updatedPost;

        state = state.copyWith(posts: updatedPosts);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void repost(String postId) {
    try {
      final postIndex = state.posts.indexWhere((post) => post.id == postId);
      if (postIndex >= 0) {
        final post = state.posts[postIndex];
        final updatedPost = post.copyWith(
          repostCount: post.isReposted ? post.repostCount - 1 : post.repostCount + 1,
          isReposted: !post.isReposted,
        );

        final updatedPosts = List<Post>.from(state.posts);
        updatedPosts[postIndex] = updatedPost;

        state = state.copyWith(posts: updatedPosts);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class PostState {
  final LoadState loadState;
  final BottomNavBarIndex navBarIndex;
  final List<Post> posts;

  PostState({
    required this.loadState,
    required this.navBarIndex,
    required this.posts,
  });

  factory PostState.initial() => PostState(
        navBarIndex: BottomNavBarIndex.posts,
        loadState: LoadState.loading,
        posts: [],
      );

  PostState copyWith({
    BottomNavBarIndex? navBarIndex,
    LoadState? loadState,
    List<Post>? posts,
  }) =>
      PostState(
        navBarIndex: navBarIndex ?? this.navBarIndex,
        loadState: loadState ?? this.loadState,
        posts: posts ?? this.posts,
      );
}

final postsProvider = NotifierProvider.autoDispose<PostNotifier, PostState>(
  PostNotifier.new,
);
