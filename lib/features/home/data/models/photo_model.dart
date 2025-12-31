class PhotoModel {
  final String id;
  final String userId;
  final String imageUrl;
  final String? thumbnailUrl;
  final String createdAt;
  final String memoryId;

  PhotoModel({
    required this.id,
    required this.userId,
    required this.imageUrl,
    this.thumbnailUrl,
    required this.createdAt,
    required this.memoryId,
  });
  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
      id: map['p_id'] ?? '',
      userId: map['u_id'] ?? '',
      imageUrl: map['image_url'] ?? '',
      thumbnailUrl: map['thumbnail_url'],
      createdAt: map['created_at'].toString(),
      memoryId: map['m_id'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'p_id': id,
      'u_id': userId,
      'image_url': imageUrl,
      'thumbnail_url': thumbnailUrl,
      'created_at': DateTime.now(),
      'm_id': memoryId,
    };
  }
}
