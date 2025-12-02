class UserModel {
  final String id;
  final String username;
  final String email;
  final String profileImage;
  final String backgroundImage;
  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.profileImage,
    required this.backgroundImage,
  });
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['u_id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      profileImage: map['profile_image'],
      backgroundImage: map['background_image'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'u_id': id,
      'username': username,
      'email': email,
      'profile_image': profileImage,
      'background_image': backgroundImage,
    };
  }
}
