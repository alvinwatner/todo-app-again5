import 'package:todo_app_v5/models/user.dart';

class ProfileRepository {
  User? _user;

  Future<User?> loadUser() async {
    // In a real app, this would load from secure storage or an API
    if (_user == null) {
      _user = const User(
        id: '1',
        name: 'Default User',
        email: 'user@example.com',
      );
    }
    return _user;
  }

  Future<void> saveUser(User user) async {
    // In a real app, this would save to secure storage or an API
    _user = user;
  }

  Future<void> deleteUser() async {
    // In a real app, this would clear from secure storage or make an API call
    _user = null;
  }
}
