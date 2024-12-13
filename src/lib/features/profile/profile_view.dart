import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app_v5/features/profile/profile_viewmodel.dart';
import 'package:todo_app_v5/ui/common/app_colors.dart';
import 'package:todo_app_v5/ui/common/ui_helpers.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: viewModel.navigateBack,
        ),
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildProfileImage(viewModel),
                  verticalSpaceMedium,
                  Text(
                    viewModel.userName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  verticalSpaceMedium,
                  _buildProfileInfo(viewModel),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileImage(ProfileViewModel viewModel) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: kcPrimaryColor, width: 3),
          ),
          child: ClipOval(
            child: viewModel.userImageUrl != null
                ? Image.network(
                    viewModel.userImageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildDefaultProfileImage(),
                  )
                : _buildDefaultProfileImage(),
          ),
        ),
        FloatingActionButton.small(
          onPressed: viewModel.updateProfileImage,
          child: const Icon(Icons.camera_alt),
        ),
      ],
    );
  }

  Widget _buildDefaultProfileImage() {
    return Container(
      color: kcMediumGrey,
      child: const Icon(
        Icons.person,
        color: Colors.white,
        size: 60,
      ),
    );
  }

  Widget _buildProfileInfo(ProfileViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: Text(viewModel.userEmail),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              trailing: Switch(
                value: viewModel.notificationsEnabled,
                onChanged: viewModel.toggleNotifications,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ProfileViewModel viewModelBuilder(BuildContext context) => ProfileViewModel();

  @override
  void onViewModelReady(ProfileViewModel viewModel) => viewModel.initialize();
}
