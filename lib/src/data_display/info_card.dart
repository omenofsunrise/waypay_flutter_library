import 'package:flutter/material.dart';

import '../layout/surface_card.dart';
import '../theme/app_colors.dart';
import '../theme/app_style.dart';
import 'info_item.dart';

class WayPayInfoField {
  const WayPayInfoField({
    this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
    this.valueTextAlign = TextAlign.start,
    this.onTap,
  });

  final String? label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final TextAlign valueTextAlign;
  final VoidCallback? onTap;
}

class WayPayInfoCard extends StatelessWidget {
  const WayPayInfoCard({
    super.key,
    this.title,
    required this.fields,
    this.fieldsPerRow = 1,
    this.onTap,
    this.showShadow = true,
    this.showBorder = false,
  }) : assert(fieldsPerRow > 0);

  final String? title;
  final List<WayPayInfoField> fields;
  final int fieldsPerRow;
  final VoidCallback? onTap;
  final bool showShadow;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return WayPaySurfaceCard(
      onTap: onTap,
      showShadow: showShadow,
      showBorder: showBorder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: AppStyle.manrope(
                size: 15,
                weight: FontWeight.w600,
                color: const Color(AppColors.uiBorder),
              ),
            ),
            const SizedBox(height: 12),
          ],
          ..._rows(),
        ],
      ),
    );
  }

  List<Widget> _rows() {
    final result = <Widget>[];
    for (var index = 0; index < fields.length; index += fieldsPerRow) {
      final row = fields.skip(index).take(fieldsPerRow).toList();
      result.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var itemIndex = 0; itemIndex < fieldsPerRow; itemIndex++) ...[
              if (itemIndex > 0) const SizedBox(width: 16),
              Expanded(
                child: itemIndex >= row.length
                    ? const SizedBox.shrink()
                    : WayPayInfoItem(
                        label: row[itemIndex].label ?? '',
                        value: row[itemIndex].value,
                        onTap: row[itemIndex].onTap,
                        labelStyle: row[itemIndex].labelStyle,
                        valueStyle: row[itemIndex].valueStyle,
                        alignRight:
                            row[itemIndex].valueTextAlign == TextAlign.right,
                      ),
              ),
            ],
          ],
        ),
      );
      if (index + fieldsPerRow < fields.length) {
        result.add(const SizedBox(height: 12));
      }
    }
    return result;
  }
}
