class Post {
  final String description;
  final String id;
  final String link;
  final bool noMedia;
  final String thumbnail;
  final int timestamp;
  final String userId;
  final String username;
  final dynamic video;
  final int likeCount;
  final int repostCount;
  final bool isLiked;
  final bool isReposted;

  Post({
    required this.description,
    required this.id,
    required this.link,
    required this.noMedia,
    required this.thumbnail,
    required this.timestamp,
    required this.userId,
    required this.username,
    required this.video,
    this.likeCount = 0,
    this.repostCount = 0,
    this.isLiked = false,
    this.isReposted = false,
  });

  factory Post.fromMap(Map<String, dynamic> data) {
    return Post(
      description: data['description'] ?? '',
      id: data['id'] ?? '',
      link: data['link'] ?? '',
      noMedia: data['no_media'] ?? false,
      thumbnail: data['thumbnail'] ?? '',
      timestamp: data['timestamp'] ?? 0,
      userId: data['userId'] ?? '',
      username: data['username'] ?? '',
      video: data['video'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'id': id,
      'link': link,
      'no_media': noMedia,
      'thumbnail': thumbnail,
      'timestamp': timestamp,
      'userId': userId,
      'username': username,
      'video': video,
      'likeCount': likeCount,
    };
  }

  /// The [copyWith] method creates a copy of the current `Post` object
  /// with updated values for the specified fields.
  Post copyWith({
    String? description,
    String? id,
    String? link,
    bool? noMedia,
    String? thumbnail,
    int? timestamp,
    String? userId,
    String? username,
    dynamic video,
    int? likeCount,
    int? repostCount,
    bool? isLiked,
    bool? isReposted,
  }) {
    return Post(
      description: description ?? this.description,
      id: id ?? this.id,
      link: link ?? this.link,
      noMedia: noMedia ?? this.noMedia,
      thumbnail: thumbnail ?? this.thumbnail,
      timestamp: timestamp ?? this.timestamp,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      video: video ?? this.video,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      repostCount: repostCount ?? this.repostCount,
      isReposted: isReposted ?? this.isReposted,
    );
  }

  ///[video] is unstable and may at times be returned as a String or boolean.
  ///This getter handles that case and returns a converted boolean value if video is a string
  bool get videoBooleanValue {
    if (video == null) return false;
    if (video is bool) return video;
    if (video is String) {
      return (video.toLowerCase() == 'true');
    }
    return false;
  }

  bool get isText => noMedia == true;
  bool get isImage => noMedia == false && videoBooleanValue == false;
  bool get isVideo => noMedia == false && videoBooleanValue == true;
  DateTime get getDateTime =>
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  @override
  String toString() {
    return 'Post{'
        ' description: $description,'
        ' id: $id,'
        ' link: $link,'
        ' noMedia: $noMedia,'
        ' thumbnail: $thumbnail,'
        ' timestamp: $timestamp,'
        ' userId: $userId,'
        ' username: $username,'
        ' video: $video'
        '}';
  }
}
