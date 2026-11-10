import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_style.dart';
import '../theme/app_tokens.dart';
import 'bottom_sheet_shell.dart';

class WayPayActionSheetItem<T> {
  const WayPayActionSheetItem({
    required this.value,
    required this.label,
    required this.icon,
    this.isDestructive = false,
    this.enabled = true,
  });

  final T value;
  final String label;
  final IconData icon;
  final bool isDestructive;
  final bool enabled;
}

Future<T?> showWayPayActionSheet<T>({
  required BuildContext context,
  required List<WayPayActionSheetItem<T>> items,
  String title = 'Действия',
}) {
  return showWayPayBottomSheet<T>(
    context: context,
    enableDrag: false,
    builder: (sheetContext) => WayPayBottomSheet(
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _WayPayActionSheetTile<T>(
              item: items[index],
              onSelected: (value) => Navigator.of(sheetContext).pop(value),
            ),
            if (index < items.length - 1)
              const Divider(height: 1, color: Color(0xFFEEF1F4)),
          ],
        ],
      ),
    ),
  );
}

class WayPayOverflowMenuButton<T> extends StatelessWidget {
  const WayPayOverflowMenuButton({
    super.key,
    required this.items,
    required this.onSelected,
    this.title = 'Действия',
  });

  final List<WayPayActionSheetItem<T>> items;
  final ValueChanged<T> onSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: title,
      onPressed: () async {
        final value = await showWayPayActionSheet<T>(
          context: context,
          title: title,
          items: items,
        );
        if (value != null && context.mounted) onSelected(value);
      },
      icon: const Icon(Icons.more_horiz),
    );
  }
}

class _WayPayActionSheetTile<T> extends StatelessWidget {
  const _WayPayActionSheetTile({required this.item, required this.onSelected});

  final WayPayActionSheetItem<T> item;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    final color = item.isDestructive
        ? const Color(AppColors.red)
        : const Color(AppColors.black);
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.control),
      onTap: item.enabled ? () => onSelected(item.value) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
        child: Row(
          children: [
            Icon(item.icon, size: 22, color: color),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                item.label,
                style: AppStyle.manrope(
                  size: 16,
                  weight: FontWeight.w500,
                  color: item.enabled ? color : const Color(AppColors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
