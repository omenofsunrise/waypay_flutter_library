import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waypay_flutter_library/assets/resources.dart';

import '../theme/app_colors.dart';
import '../overlays/bottom_sheet_shell.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({
    super.key,
    required this.onTap,
    required this.isActive,
    this.iconAsset = SvgIcons.filter,
    this.iconPackage = 'waypay_flutter_library',
    this.activeIconColor,
  });

  final Future<void> Function() onTap;
  final bool isActive;
  final String iconAsset;
  final String? iconPackage;
  final Color? activeIconColor;

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool _isOpen = false;

  Future<void> _openFilters() async {
    setState(() => _isOpen = true);
    await widget.onTap();
    if (mounted) {
      setState(() => _isOpen = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool highlight = _isOpen || widget.isActive;
    final Color background = highlight
        ? const Color(AppColors.primary)
        : Colors.white;
    final Color iconColor = highlight
        ? widget.activeIconColor ?? const Color(0xFFB8BEC8)
        : const Color(0xFF6B717C);

    return SizedBox(
      width: 48,
      height: 48,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _openFilters,
          child: Center(
            child: SvgPicture.asset(
              widget.iconAsset,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}

class FilterSheet extends StatelessWidget {
  const FilterSheet({
    super.key,
    required this.child,
    this.title = 'Фильтры',
    this.padding,
    this.keepHeaderPinned = false,
  });

  final Widget child;
  final String title;
  final EdgeInsets? padding;
  final bool keepHeaderPinned;

  @override
  Widget build(BuildContext context) {
    return WayPayBottomSheet(
      title: title,
      padding: padding ?? const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: keepHeaderPinned
          ? ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * .7,
              ),
              child: SingleChildScrollView(child: child),
            )
          : child,
    );
  }
}
