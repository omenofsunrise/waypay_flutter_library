import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:waypay_styles/assets/resources.dart';

import '../theme/app_colors.dart';
import '../theme/app_style.dart';

class Header extends StatelessWidget {
  final String title;
  final String? fullName;
  final String? photoPath;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool showNotifications;
  final Widget? trailing;
  final GlobalKey? titleKey;
  final bool showAvatar;
  final Widget? notificationsButton;

  const Header({
    super.key,
    this.title = 'Добро пожаловать!',
    this.fullName,
    this.photoPath,
    this.showBackButton = false,
    this.onBackPressed,
    this.showNotifications = true,
    this.trailing,
    this.titleKey,
    this.showAvatar = true,
    this.notificationsButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
      child: Row(
        children: [
          showBackButton
              ? Material(
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      if (onBackPressed != null) {
                        onBackPressed!();
                        return;
                      }
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/');
                      }
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: SvgPicture.asset(SvgIcons.chevronLeft),
                      ),
                    ),
                  ),
                )
              : showAvatar
              ? GestureDetector(onTap: () {}, child: _buildAvatar())
              : const SizedBox(width: 10),
          const SizedBox(width: 12),
          Expanded(
            child: KeyedSubtree(
              key: titleKey,
              child: Text(
                title,
                style: AppStyle.semiBold23.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          if (showNotifications) ...[
            const SizedBox(width: 12),
            notificationsButton ??
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(SvgIcons.notifications),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
            const SizedBox(width: 3),
          ],
          if (trailing != null) ...[const SizedBox(width: 12), trailing!],
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    if (photoPath != null) {
      return CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(photoPath!),
      );
    } else {
      final String initials = _getInitials(fullName ?? '');
      return Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Color(AppColors.primary),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            initials,
            style: AppStyle.medium16.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
  }

  String _getInitials(String fullName) {
    final List<String> parts = fullName
        .trim()
        .split(RegExp(r'\\s+'))
        .where((String part) => part.isNotEmpty)
        .toList();
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    if (parts.isNotEmpty) {
      return parts.first[0].toUpperCase();
    }
    return 'U';
  }
}
