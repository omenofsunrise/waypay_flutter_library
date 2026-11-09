import 'package:flutter/material.dart';

abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

abstract final class AppRadii {
  static const double control = 8;
  static const double card = 12;
  static const double modal = 16;
  static const double pill = 999;
}

abstract final class AppDurations {
  static const Duration fast = Duration(milliseconds: 160);
  static const Duration normal = Duration(milliseconds: 240);
}

abstract final class AppShadows {
  static const List<BoxShadow> card = [
    BoxShadow(color: Color(0x14000809), offset: Offset(2, 2), blurRadius: 4),
    BoxShadow(color: Color(0x05000809), blurRadius: 6),
  ];
}
