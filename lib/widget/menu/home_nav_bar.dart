import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_color.dart';

class HomeNavBar extends StatelessWidget {
  final bool isShowBackButton;
  final String title;
  const HomeNavBar({
    super.key,
    required this.title,
    this.isShowBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 141.h,
      padding: EdgeInsets.symmetric(
        horizontal: 47.w,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (isShowBackButton)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: BackButton(),
            ),
          Text(
            title,
            style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.mainGrey),
          ),
          const Spacer(),
          CircleAvatar(child: Image.asset("assets/png/prfile_img1.png"))
        ],
      ),
    );
  }
}
