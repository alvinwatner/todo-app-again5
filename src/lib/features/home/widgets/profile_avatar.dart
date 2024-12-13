import 'package:flutter/material.dart';
import 'package:todo_app_v5/ui/common/app_colors.dart';
import 'package:todo_app_v5/ui/common/ui_helpers.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onTap;

  const ProfileAvatar({
    Key? key,
    this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: kcLightGrey,
              width: 2,
            ),
          ),
          child: ClipOval(
            child: imageUrl != null
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildDefaultAvatar(),
                  )
                : _buildDefaultAvatar(),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: kcMediumGrey,
      child: const Icon(
        Icons.person,
        color: Colors.white,
        size: 24,
      ),
    );
  }
}
