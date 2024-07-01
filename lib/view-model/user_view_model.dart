import 'package:blinqpost/model/user_model.dart';
import 'package:blinqpost/services/firestore_service.dart';
import 'package:blinqpost/utils/enums.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserNotifier extends AutoDisposeNotifier<UsersState> {
  late FireStoreService _service;

  @override
  UsersState build() {
    _service = ref.read(remoteStorageProvider);
    fetchUsers();
    return UsersState.initial();
  }

  void fetchUsers() async {
    try {
      final response = await _service.getUsers();
      if (response.success == false) throw Exception(response.message);
      print(response.data!.first);
      state = state.copyWith(
        users: response.data,
        loadState: LoadState.success,
      );
    } catch (e) {
      state = state.copyWith(loadState: LoadState.error);
      print(e.toString());
    }
  }
}

class UsersState {
  final LoadState loadState;
  final List<User> users;

  UsersState({
    required this.loadState,
    required this.users,
  });

  factory UsersState.initial() => UsersState(
        loadState: LoadState.loading,
        users: [],
      );

  UsersState copyWith({
    LoadState? loadState,
    List<User>? users,
  }) =>
      UsersState(
        loadState: loadState ?? this.loadState,
        users: users ?? this.users,
      );
}

final usersProvider = NotifierProvider.autoDispose<UserNotifier, UsersState>(
  UserNotifier.new,
);
