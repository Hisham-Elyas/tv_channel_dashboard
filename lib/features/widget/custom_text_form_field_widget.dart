import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_color.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final double? height;
  final double? width;
  final int? maxLines;
  final String? initialValue;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.height,
    this.width,
    this.maxLines = 1,
    this.onSaved,
    this.validator,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.backgroundColor3,
      elevation: 5,
      child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.only(left: 10.w),
          decoration: BoxDecoration(
              color: AppColor.backgroundColor2,
              borderRadius: BorderRadius.circular(10.r)),
          child: TextFormField(
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            maxLines: maxLines,
            autocorrect: true,
            cursorHeight: 30.h,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle:
                  TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp),
            ),
          )),
    );
  }
}
