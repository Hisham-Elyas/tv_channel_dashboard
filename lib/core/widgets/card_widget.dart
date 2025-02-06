import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';

class CardWidget extends StatelessWidget {
  final Widget child;
  final double? horizontal;
  final double? vertical;
  final double? width;
  final double? height;
  const CardWidget(
      {super.key,
      required this.child,
      this.horizontal,
      this.vertical,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(15.r),
        elevation: 10,
        shadowColor: ColorsManager.lightSecondary,
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: horizontal ?? 0, vertical: vertical ?? 0),
            width: width,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: Theme.of(context).colorScheme.surface),
            child: child));
  }
}
