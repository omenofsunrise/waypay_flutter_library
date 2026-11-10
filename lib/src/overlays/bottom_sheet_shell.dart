import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_style.dart';
import '../theme/app_tokens.dart';

class WayPayBottomSheet extends StatelessWidget {
  const WayPayBottomSheet({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.onClose,
    this.footer,
    this.padding = const EdgeInsets.fromLTRB(24, 8, 24, 24),
    this.scrollable = true,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final VoidCallback? onClose;
  final Widget? footer;
  final EdgeInsetsGeometry padding;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFD1D5DB),
                borderRadius: BorderRadius.circular(AppRadii.pill),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 12, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppStyle.manrope(
                            size: 22,
                            weight: FontWeight.w700,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            subtitle!,
                            style: AppStyle.manrope(
                              size: 13,
                              weight: FontWeight.w400,
                              color: const Color(AppColors.uiBorder),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onClose ?? () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Flexible(
              child: scrollable
                  ? SingleChildScrollView(padding: padding, child: child)
                  : Padding(padding: padding, child: child),
            ),
            if (footer != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: footer!,
              ),
          ],
        ),
      ),
    );
  }
}

Future<T?> showWayPayBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isScrollControlled = true,
  bool useSafeArea = true,
  bool useRootNavigator = false,
  Color? backgroundColor,
  Color? barrierColor,
  ShapeBorder? shape,
  Clip? clipBehavior,
  BoxConstraints? constraints,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    useSafeArea: useSafeArea,
    useRootNavigator: useRootNavigator,
    backgroundColor: backgroundColor ?? const Color(AppColors.white),
    barrierColor: barrierColor,
    shape:
        shape ??
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadii.modal),
          ),
        ),
    clipBehavior: clipBehavior ?? Clip.antiAlias,
    constraints: constraints,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    builder: builder,
  );
}
