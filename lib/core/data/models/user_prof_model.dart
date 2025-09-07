class UserProfile {
  final String name;
  final String imageUrl;
  final int followers;
  final List<String> interests;

  UserProfile({
    required this.name,
    required this.imageUrl,
    required this.followers,
    required this.interests,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? 'اسم المستخدم',
      imageUrl: json['image_url'] ?? 'https://via.placeholder.com/150',
      followers: json['followers'] ?? 0,
      interests: List<String>.from(json['interests'] ?? []),
    );
  }
}
