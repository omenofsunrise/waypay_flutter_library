import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waypay_styles/waypay_styles.dart';

class WaypayBottomNavItem {
  const WaypayBottomNavItem({required this.icon, this.activeIcon});

  final String icon;
  final String? activeIcon;
}

class WaypayBottomNavBar extends StatelessWidget {
  const WaypayBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor = const Color(AppColors.white),
    this.iconColor = const Color(AppColors.uiBorder),
    this.activeColor = const Color(AppColors.primary),
    this.borderColor,
    this.padding = const EdgeInsets.fromLTRB(16, 10, 16, 10),
    this.itemSize = const Size(56, 48),
    this.iconSize = 26,
    this.borderRadius = const BorderRadius.vertical(top: Radius.circular(16)),
  });

  final List<WaypayBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color backgroundColor;
  final Color iconColor;
  final Color activeColor;
  final Color? borderColor;
  final EdgeInsets padding;
  final Size itemSize;
  final double iconSize;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Container(
      color: backgroundColor,
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
          border: Border(
            top: BorderSide(
              color: borderColor ?? Colors.black.withOpacity(0.06),
              width: 1,
            ),
          ),
        ),
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final selected = currentIndex == index;
            final iconPath = selected
                ? (item.activeIcon ?? item.icon)
                : item.icon;
            return _NavItem(
              icon: iconPath,
              selected: selected,
              activeColor: activeColor,
              iconColor: iconColor,
              itemSize: itemSize,
              iconSize: iconSize,
              onTap: () => onTap(index),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.selected,
    required this.onTap,
    required this.activeColor,
    required this.iconColor,
    required this.itemSize,
    required this.iconSize,
  });

  final String icon;
  final bool selected;
  final VoidCallback onTap;
  final Color activeColor;
  final Color iconColor;
  final Size itemSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        width: itemSize.width,
        height: itemSize.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: SvgPicture.asset(
          icon,
          width: iconSize,
          height: iconSize,
          colorFilter: ColorFilter.mode(
            selected ? const Color(AppColors.white) : iconColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
