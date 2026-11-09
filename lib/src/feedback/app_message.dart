import 'dart:async';

import 'package:flutter/material.dart';
import 'package:waypay_flutter_library/src/theme/app_colors.dart';
import 'package:waypay_flutter_library/src/theme/app_style.dart';

enum AppMessageType { info, success, error }

OverlayEntry? _currentAppMessage;
Timer? _currentAppMessageTimer;

void showAppMessage(
  BuildContext context,
  String message, {
  AppMessageType type = AppMessageType.info,
  Duration duration = const Duration(seconds: 3),
}) {
  if (!context.mounted) return;

  final overlay = Overlay.maybeOf(context, rootOverlay: true);
  if (overlay == null) return;

  _currentAppMessageTimer?.cancel();
  _currentAppMessage?.remove();

  final entry = OverlayEntry(
    builder: (context) => _AppMessageOverlay(message: message, type: type),
  );

  _currentAppMessage = entry;
  overlay.insert(entry);
  _currentAppMessageTimer = Timer(duration, hideAppMessage);
}

void hideAppMessage() {
  _currentAppMessageTimer?.cancel();
  _currentAppMessageTimer = null;
  _currentAppMessage?.remove();
  _currentAppMessage = null;
}

class _AppMessageOverlay extends StatelessWidget {
  const _AppMessageOverlay({required this.message, required this.type});

  final String message;
  final AppMessageType type;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final theme = _MessageTheme.fromType(type);

    return Positioned(
      left: 16,
      right: 16,
      bottom: media.viewInsets.bottom + media.padding.bottom + 20,
      child: SafeArea(
        top: false,
        child: Material(
          color: Colors.transparent,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: theme.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.border),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1F000000),
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(theme.icon, color: theme.foreground, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      message,
                      style: AppStyle.manrope(
                        size: 14,
                        weight: FontWeight.w500,
                        color: theme.foreground,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: hideAppMessage,
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Icon(
                        Icons.close,
                        color: theme.foreground,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MessageTheme {
  const _MessageTheme({
    required this.background,
    required this.border,
    required this.foreground,
    required this.icon,
  });

  final Color background;
  final Color border;
  final Color foreground;
  final IconData icon;

  factory _MessageTheme.fromType(AppMessageType type) {
    switch (type) {
      case AppMessageType.success:
        return const _MessageTheme(
          background: Color(0xFFEAF8F0),
          border: Color(0xFFC8EBD5),
          foreground: Color(AppColors.primary),
          icon: Icons.check_circle_outline,
        );
      case AppMessageType.error:
        return const _MessageTheme(
          background: Color(0xFFFFEEF0),
          border: Color(0xFFFFCDD2),
          foreground: Color(AppColors.red),
          icon: Icons.error_outline,
        );
      case AppMessageType.info:
        return const _MessageTheme(
          background: Colors.white,
          border: Color(0xFFE2E4EA),
          foreground: Color(AppColors.black),
          icon: Icons.info_outline,
        );
    }
  }
}
