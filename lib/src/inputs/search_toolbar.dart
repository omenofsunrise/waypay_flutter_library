import 'package:flutter/material.dart';

import '../buttons/add_button.dart';
import 'search_field.dart';

class WayPaySearchToolbar extends StatelessWidget {
  const WayPaySearchToolbar({
    super.key,
    required this.controller,
    this.hintText,
    this.onChanged,
    this.onAdd,
    this.addTooltip = 'Добавить',
    this.trailing,
  });

  final TextEditingController controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onAdd;
  final String addTooltip;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchField(
            controller: controller,
            hintText: hintText ?? 'Поиск...',
            onChanged: onChanged,
          ),
        ),
        if (trailing != null) ...[const SizedBox(width: 8), trailing!],
        if (onAdd != null) ...[
          const SizedBox(width: 8),
          Tooltip(
            message: addTooltip,
            child: AddButton(onPressed: onAdd!),
          ),
        ],
      ],
    );
  }
}
