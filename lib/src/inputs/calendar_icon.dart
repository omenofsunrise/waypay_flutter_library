import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../assets/resources.dart';

class WayPayCalendarIcon extends StatelessWidget {
  const WayPayCalendarIcon({
    super.key,
    this.size = 20,
    this.color = const Color(0xFF6B717C),
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      SvgIcons.calendar,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
