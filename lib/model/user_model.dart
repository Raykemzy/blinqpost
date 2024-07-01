class User {
  final String bio;
  final String name;
  final String userName;
  final String? photo;
  final String? userId;

  User({
    required this.bio,
    required this.name,
    required this.userName,
    this.photo,
    this.userId,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      bio: data['bio'] ?? '',
      name: data['name'] ?? '',
      userName: data['userName'] ?? '',
      photo: data['photo'] ?? false,
      userId: data['userId'] ?? '',
    );
  }

  @override
  String toString() {
    return 'User{'
        ' bio: $bio,'
        ' name: $name,'
        ' userName: $userName,'
        ' photo: $photo,'
        ' userId: $userId,'
        '}';
  }
}
