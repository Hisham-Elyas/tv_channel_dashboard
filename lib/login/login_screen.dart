import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_color.dart';
import '../widget/custom_buttom_widget.dart';
import '../widget/custom_text_form_field_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/png/Rectangl_backgrwnd.png"),
                fit: BoxFit.cover)),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(height: 45.h),
          Image.asset(
            "assets/png/welcome-photos-png.png",
            height: 400.h,
            width: 610.w,
          ),
          SizedBox(height: 20.h),
          Column(
            children: [
              CustomTextFormField(
                hintText: "Username",
                width: 400.w,
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                hintText: "password",
                width: 400.w,
              ),
              SizedBox(height: 34.h),
              CustomButtom(
                  width: 400.w,
                  height: 60.h,
                  onTap: () {},
                  color: AppColor.mainColor,
                  title: "login")
            ],
          )
        ]),
      ),
    );
  }
}
