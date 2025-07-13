import '../models/user_profile.dart';

class UserService {
  // In a real app, this would fetch from a backend or local storage
  UserProfile getCurrentUser() {
    return UserProfile(
      name: 'Afsar Hossen',
      email: 'lmshuvo97@gmail.com',
      avatarPath: 'lib/assets/images/profile.png',
    );
  }
}
