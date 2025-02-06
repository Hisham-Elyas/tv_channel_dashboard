import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_color.dart';

class LogoCardWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final double? borderRadius;

  const LogoCardWidget({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20.r),
      elevation: 10,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 35.h,
        ),
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 20.r),
            color: AppColor.mainBlack),
        child: Image.asset("assets/png/Tv Channel.png", fit: BoxFit.contain),
      ),
    );
  }
}
