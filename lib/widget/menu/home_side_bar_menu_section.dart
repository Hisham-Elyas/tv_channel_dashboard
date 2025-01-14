import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app_color.dart';
import '../../page_controller.dart';
import '../logo_card_widget.dart';

class SideMenuSection extends StatelessWidget {
  SideMenuSection({super.key});
  final List<String> drawerItems = [
    'Home',
    'Channels',
    'Categories',
    'Settings',
    'Logout',
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.mainGrey,
      child: SafeArea(
          child: SizedBox(
        height: 1117.h,
        width: 315.w,
        child: Column(
          children: [
            const AspectRatio(
              aspectRatio: 3,
              child: LogoCardWidget(
                borderRadius: 0,
              ),
            ),
            Expanded(
              child: GetBuilder<PagesController>(
                  builder: (controller) => ListView.builder(
                        padding: EdgeInsets.only(top: 20.h),
                        itemCount: drawerItems.length,
                        itemBuilder: (context, index) => SideMenuButton(
                          text: drawerItems[index],
                          numTap: controller.pageNum == index,
                          onPressed: () {
                            controller.goToPage(index);
                          },
                        ),
                      )),
            )
          ],
        ),
      )),
    );
  }
}

class SideMenuButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final bool numTap;
  const SideMenuButton({
    super.key,
    this.onPressed,
    required this.text,
    this.numTap = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 52.h),
        child: ListTile(
          onTap: onPressed,
          title: Text(
            text,
            style: TextStyle(
                color: numTap ? AppColor.mainBlack : AppColor.fontColor1,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold),
          ),
        ));
  }
}
