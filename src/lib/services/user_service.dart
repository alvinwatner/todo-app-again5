import 'package:stacked/stacked.dart';
import 'package:todo_app_v5/app/app.locator.dart';
import 'package:todo_app_v5/features/profile/profile_repository.dart';
import 'package:todo_app_v5/models/user.dart';

class UserService {
  final _repository = locator<ProfileRepository>();

  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<void> initialize() async {
    try {
      _currentUser = await _repository.loadUser();
    } catch (e) {
      _currentUser = null;
    }
  }

  Future<void> updateUser(User user) async {
    try {
      await _repository.saveUser(user);
      _currentUser = user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearUser() async {
    try {
      await _repository.deleteUser();
      _currentUser = null;
    } catch (e) {
      rethrow;
    }
  }

  bool get hasUser => _currentUser != null;
  String? get userImageUrl => _currentUser?.imageUrl;
  String get userName => _currentUser?.name ?? 'Guest User';
}