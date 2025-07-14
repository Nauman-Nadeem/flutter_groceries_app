// Model for UserProfile
// This class represents a user profile with basic details and can be used to create an instance from a JSON map.

class UserProfile {
  final String name;
  final String email;
  final String avatarPath;

  UserProfile({
    required this.name,
    required this.email,
    required this.avatarPath,
  });
}
