class CommentModel {
  final String cId;
  final DateTime createdAt;
  final String uId;
  final String mId;
  final String? text;

  CommentModel({
    required this.cId,
    required this.createdAt,
    required this.uId,
    required this.mId,
    this.text,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      cId: json['c_id'] as String,
      createdAt: DateTime.parse(json['created_at']),
      uId: json['u_id'] as String,
      mId: json['m_id'] as String,
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'c_id': cId,
      'created_at': createdAt.toIso8601String(),
      'u_id': uId,
      'm_id': mId,
      'text': text,
    };
  }

  Map<String, dynamic> toInsertJson() {
    return {'u_id': uId, 'm_id': mId, 'text': text};
  }

  CommentModel copyWith({
    String? cId,
    DateTime? createdAt,
    String? uId,
    String? mId,
    String? text,
  }) {
    return CommentModel(
      cId: cId ?? this.cId,
      createdAt: createdAt ?? this.createdAt,
      uId: uId ?? this.uId,
      mId: mId ?? this.mId,
      text: text ?? this.text,
    );
  }
}
