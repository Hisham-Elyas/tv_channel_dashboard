import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_color.dart';
import '../responsive.dart';
import '../widget/custom_buttom_widget.dart';
import '../widget/custom_text_form_field_widget.dart';
import '../widget/menu/home_nav_bar.dart';

class AddandEditChannelScreen extends StatelessWidget {
  final String title;
  const AddandEditChannelScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const HomeNavBar(
                title: "Channels",
                isShowBackButton: true,
              ),
            Padding(
              padding: EdgeInsets.only(left: 35.w, right: 5.w), //47* - 28*
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    color: AppColor.mainGrey,
                    child: Text(
                      "$title Channels",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(height: 10.h),
                  const CustomTextFormField(
                    hintText: "Channel Name",
                  ),
                  SizedBox(height: 10.h),
                  const CustomTextFormField(
                    hintText: "Channel Description",
                    maxLines: 2,
                  ),
                  SizedBox(height: 10.h),
                  const CustomTextFormField(
                    hintText: "Live Url",
                  ),
                  SizedBox(height: 10.h),
                  const CustomTextFormField(
                    hintText: "Thumbnail",
                  ),
                  SizedBox(height: 10.h),
                  const CustomTextFormField(
                    hintText: "Facebook",
                  ),
                  SizedBox(height: 10.h),
                  const CustomTextFormField(
                    hintText: "twitter",
                  ),
                  SizedBox(height: 10.h),
                  const CustomTextFormField(
                    hintText: "Website",
                  ),
                  SizedBox(height: 10.h),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: 'Sports',
                      items: ['Sports', 'News', 'Entertainment']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {},
                    ),
                  ),
                  SizedBox(height: 10.h),
                  CustomButtom(
                      height: 88.h,
                      color: AppColor.mainColor,
                      onTap: () {},
                      title: "Submit")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
