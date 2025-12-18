import 'package:flutter/material.dart';

import 'app_colors.dart';

class ToggleSwitch extends StatelessWidget {
  const ToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.width = 60,
    this.height = 28,
    this.padding = const EdgeInsets.all(4),
    this.enabledColor = AppColors.primary,
    this.disabledColor = AppColors.uncomfPayment,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;
  final EdgeInsets padding;
  final int enabledColor;
  final int disabledColor;

  @override
  Widget build(BuildContext context) {
    final double knobSize = height - padding.vertical;

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: Color(value ? enabledColor : disabledColor),
          borderRadius: BorderRadius.circular(height),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000809),
              offset: Offset(2, 2),
              blurRadius: 4,
            ),
            BoxShadow(
              color: Color(0x05000809),
              offset: Offset(0, 0),
              blurRadius: 6,
            ),
          ],
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: knobSize,
            height: knobSize,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x14000809),
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
                BoxShadow(
                  color: Color(0x05000809),
                  offset: Offset(0, 0),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
