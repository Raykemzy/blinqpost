import 'package:blinqpost/model/base_response_model.dart';
import 'package:blinqpost/model/post_model.dart';
import 'package:blinqpost/services/firestore_service.dart';
import 'package:blinqpost/utils/enums.dart';
import 'package:blinqpost/view-model/post_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'post_notifier_test.mocks.dart';

@GenerateMocks([FireStoreService, FireStoreServiceImpl])
void main() {
  late MockFireStoreServiceImpl mockFireStoreService;
  late ProviderContainer container;

  ///Setup and initialize `MockFireStoreServiceImpl` && `ProviderContainer` before each test
  setUp(() {
    mockFireStoreService = MockFireStoreServiceImpl();
    container = ProviderContainer(
      overrides: [
        remoteStorageProvider.overrideWithValue(mockFireStoreService),
      ],
    );
  });

  ///Dispose
  tearDown(() {
    container.dispose();
  });

  ///Test notifiers to verify state is updated when [mockFireStoreService.getPosts()] is successful
  test('fetchPosts updates state with posts on success', () async {
    final posts = [
      Post(
        description: 'BlinqPost Post',
        id: '1',
        link: 'https://example.com',
        noMedia: false,
        thumbnail: 'https://example.com/thumbnail.jpg',
        timestamp: 1627812000,
        userId: 'user1',
        username: 'user1',
        video: null,
      ),
    ];

    when(mockFireStoreService.getPosts()).thenAnswer(
      (_) async => BaseResponse(success: true, data: posts),
    );

    final postNotifier = container.read(postsProvider.notifier);
    postNotifier.fetchPosts();

    final state = container.read(postsProvider).copyWith(
          posts: posts,
          loadState: LoadState.success,
        );

    expect(state.posts, posts);
    expect(state.loadState, LoadState.success);
  });

  ///Test notifiers to verify state is updated when [mockFireStoreService.getPosts()] is unsuccessful
  test('fetchPosts updates state with error on failure', () async {
    when(mockFireStoreService.getPosts()).thenAnswer(
      (_) async => BaseResponse(success: false, message: 'Error'),
    );

    final postNotifier = container.read(postsProvider.notifier);
    postNotifier.fetchPosts();

    final state = container.read(postsProvider).copyWith(posts: [], loadState: LoadState.error);

    expect(state.posts, []);
    expect(state.loadState, LoadState.error);
  });
}
