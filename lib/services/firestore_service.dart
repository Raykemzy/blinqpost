import 'package:blinqpost/model/base_response_model.dart';
import 'package:blinqpost/model/post_model.dart';
import 'package:blinqpost/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class FireStoreService {
  Future<BaseResponse<List<Post>>> getPosts();
  Future<BaseResponse<List<User>>> getUsers();
}

class FireStoreServiceImpl implements FireStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<BaseResponse<List<Post>>> getPosts() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('post').get();
      List<Post> posts = querySnapshot.docs.map((doc) {
        return Post.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return BaseResponse(success: true, data: posts);
    } catch (e) {
      print('Error retrieving posts: $e');
      return BaseResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<BaseResponse<List<User>>> getUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();
      List<User> users = querySnapshot.docs.map((doc) {
        return User.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return BaseResponse(success: true, data: users);
    } catch (e) {
      print('Error retrieving posts: $e');
      return BaseResponse(success: false, message: e.toString());
    }
  }
}

final remoteStorageProvider = Provider<FireStoreServiceImpl>((ref) => FireStoreServiceImpl());