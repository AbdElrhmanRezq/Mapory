class MemoryModel {
  final DateTime createdAt;
  final String caption;
  final String userId;
  final String memoryId;
  final double lat;
  final double long;

  const MemoryModel({
    required this.createdAt,
    required this.caption,
    required this.userId,
    required this.memoryId,
    required this.lat,
    required this.long,
  });

  factory MemoryModel.fromMap(Map<String, dynamic> map) {
    return MemoryModel(
      createdAt: DateTime.parse(map['created_at']),
      caption: map['caption'] ?? '',
      userId: map['u_id'],
      memoryId: map['m_id'],
      lat: (map['lat'] as num).toDouble(),
      long: (map['long'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt.toIso8601String(),
      'caption': caption,
      'u_id': userId,
      'm_id': memoryId,
      'lat': lat,
      'long': long,
    };
  }
}
