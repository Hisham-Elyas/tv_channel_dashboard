import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_color.dart';
import '../../responsive.dart';
import '../widget/custom_buttom_widget.dart';
import '../widget/custom_text_form_field_widget.dart';
import '../widget/menu/home_nav_bar.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const HomeNavBar(
                title: "Categories",
                isShowBackButton: true,
              ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 35.w, vertical: 28.h), //47* - 28*
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 28.h),
                color: AppColor.mainGrey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Categories",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(height: 10.h),
                    const CustomTextFormField(
                      hintText: "Category Name",
                    ),
                    SizedBox(height: 10.h),
                    const CustomTextFormField(
                      hintText: "Category Image",
                    ),
                    SizedBox(height: 25.h),
                    CustomButtom(
                        height: 88.h,
                        color: AppColor.mainColor,
                        onTap: () {},
                        title: "Submit")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
