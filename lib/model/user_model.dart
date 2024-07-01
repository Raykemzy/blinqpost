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

  static User getUser() => User(
        bio: "Passionate Flutter developer.",
        name: "Alice Johnson",
        userName: "alice_j",
        photo:
            "https://plus.unsplash.com/premium_photo-1666789257876-176a05094875?q=80&w=2487&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        userId: "user123",
      );
}
