import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:waypay_flutter_library/assets/resources.dart';

import '../theme/app_colors.dart';
import '../theme/app_style.dart';

class Header extends StatelessWidget {
  final String title;
  final Widget? titleWidget;
  final String? fullName;
  final String? photoPath;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool showNotifications;
  final Widget? trailing;
  final GlobalKey? titleKey;
  final bool showAvatar;
  final Widget? notificationsButton;
  final String backIconAsset;
  final String notificationsIconAsset;
  final String? iconPackage;
  final String fallbackRoute;
  final VoidCallback? onAvatarTap;
  final String? avatarRouteName;

  const Header({
    super.key,
    this.title = 'Добро пожаловать!',
    this.titleWidget,
    this.fullName,
    this.photoPath,
    this.showBackButton = false,
    this.onBackPressed,
    this.showNotifications = true,
    this.trailing,
    this.titleKey,
    this.showAvatar = true,
    this.notificationsButton,
    this.backIconAsset = SvgIcons.chevronLeft,
    this.notificationsIconAsset = SvgIcons.notifications,
    this.iconPackage = 'waypay_flutter_library',
    this.fallbackRoute = '/',
    this.onAvatarTap,
    this.avatarRouteName,
  });

  @override
  Widget build(BuildContext context) {
    final Widget leading = showBackButton
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
                  context.go(fallbackRoute);
                }
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: SvgPicture.asset(backIconAsset),
                ),
              ),
            ),
          )
        : showAvatar
        ? GestureDetector(
            onTap: () {
              if (onAvatarTap != null) {
                onAvatarTap!();
                return;
              }
              if (avatarRouteName != null) {
                context.pushNamed(avatarRouteName!);
              }
            },
            child: _buildAvatar(),
          )
        : const SizedBox(width: 50);

    final actions = <Widget>[
      if (showNotifications)
        notificationsButton ??
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(SvgIcons.notifications),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
      if (trailing != null) trailing!,
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
      child: NavigationToolbar(
        centerMiddle: true,
        middleSpacing: 12,
        leading: leading,
        middle: KeyedSubtree(
          key: titleKey,
          child:
              titleWidget ??
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppStyle.semiBold23.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
        ),
        trailing: actions.isEmpty
            ? null
            : Row(mainAxisSize: MainAxisSize.min, children: actions),
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
        .split(RegExp(r'\s+'))
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
