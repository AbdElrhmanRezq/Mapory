class LikeModel {
  final String id;
  final String authorId;
  final String likerId;
  final String photoId;
  LikeModel({
    required this.id,
    required this.authorId,
    required this.likerId,
    required this.photoId,
  });
  factory LikeModel.fromMap(Map<String, dynamic> map) {
    return LikeModel(
      id: map['l_id'] ?? '',
      authorId: map['author_id'] ?? '',
      likerId: map['liker_id'] ?? '',
      photoId: map['p_id'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'l_id': id,
      'author_id': authorId,
      'liker_id': likerId,
      'p_id': photoId,
    };
  }
}
