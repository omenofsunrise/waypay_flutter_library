import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class WayPayDropdownField<T> extends StatelessWidget {
  const WayPayDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.value,
    this.hint,
  });

  final String label;
  final T? value;
  final String? hint;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    const inactiveColor = Color(0xFFD9DDE5);
    const activeColor = Color(AppColors.primary);
    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: 1.5),
    );

    return DropdownButtonFormField<T>(
      initialValue: value,
      isExpanded: true,
      hint: hint == null ? null : Text(hint!),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: border(inactiveColor),
        enabledBorder: border(inactiveColor),
        focusedBorder: border(activeColor),
      ),
      items: items,
      onChanged: onChanged,
    );
  }
}
