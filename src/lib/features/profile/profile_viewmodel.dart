import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_app_v5/app/app.locator.dart';
import 'package:todo_app_v5/models/user.dart';
import 'package:todo_app_v5/services/user_service.dart';

class ProfileViewModel extends BaseViewModel {
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();

  String get userName => _userService.userName;
  String? get userImageUrl => _userService.userImageUrl;
  String get userEmail =>
      _userService.currentUser?.email ?? 'No email provided';
  bool get notificationsEnabled =>
      _userService.currentUser?.notificationsEnabled ?? false;

  Future<void> initialize() async {
    await runBusyFuture(_userService.initialize());
  }

  void navigateBack() {
    _navigationService.back();
  }

  Future<void> updateProfileImage() async {
    // Implementation for updating profile image would go here
    // This would typically involve file picking and image upload
  }

  Future<void> toggleNotifications(bool enabled) async {
    final currentUser = _userService.currentUser;
    if (currentUser != null) {
      final updatedUser = currentUser.copyWith(notificationsEnabled: enabled);
      await runBusyFuture(_userService.updateUser(updatedUser));
      rebuildUi();
    }
  }
}
