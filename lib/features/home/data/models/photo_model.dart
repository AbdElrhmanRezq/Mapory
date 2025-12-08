class PhotoModel {
  final String id;
  final String userId;
  final String imageUrl;
  final String? thumbnailUrl;
  final String? caption;
  final double long;
  final double lat;
  final String visibility;
  final String createdAt;

  PhotoModel({
    required this.id,
    required this.userId,
    required this.imageUrl,
    this.thumbnailUrl,
    this.caption,
    required this.long,
    required this.lat,
    required this.visibility,
    required this.createdAt,
  });
  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
      id: map['p_id'] ?? '',
      userId: map['u_id'] ?? '',
      imageUrl: map['image_url'] ?? '',
      thumbnailUrl: map['thumbnail_url'],
      caption: map['caption'],
      long: map['long']?.toDouble() ?? 0.0,
      lat: map['lat']?.toDouble() ?? 0.0,
      visibility: map['visibility'] ?? 'public',
      createdAt: map['created_at'].toString(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'p_id': id,
      'u_id': userId,
      'image_url': imageUrl,
      'thumbnail_url': thumbnailUrl,
      'caption': caption,
      'long': long,
      'lat': lat,
      'visibility': visibility,
      'created_at': DateTime.now(),
    };
  }
}
