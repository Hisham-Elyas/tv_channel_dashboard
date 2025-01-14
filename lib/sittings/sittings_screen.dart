import '../widget/custom_buttom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../responsive.dart';
import '../widget/custom_text_form_field_widget.dart';
import '../widget/menu/home_nav_bar.dart';

class SittingsScreen extends StatelessWidget {
  const SittingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context)) const HomeNavBar(title: "Admin"),
          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  buildSettingField(
                    label: 'Your API Key:',
                    // hintText: 'Enter API Key',onTap:
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  buildSettingField(
                    label: 'Change Username:',
                    oldLabel: 'Old Username',
                    newLabel: 'New Username',
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  buildSettingField(
                    label: 'Change Password:',
                    oldLabel: 'Old Password',
                    newLabel: 'New Password',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildSettingField(
    {required String label,
    String? oldLabel,
    String? newLabel,
    void Function()? onTap}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          if (oldLabel != null)
            Expanded(
              child: CustomTextFormField(
                // decoration: InputDecoration(hintText: oldLabel),
                hintText: oldLabel,
              ),
            ),
          const SizedBox(width: 10),
          Expanded(
            child: CustomTextFormField(
              // decoration: InputDecoration(hintText: newLabel ?? 'Enter Value'),
              hintText: newLabel ?? 'Enter Value',
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      CustomButtom(
          onTap: onTap,
          width: 180.w,
          height: 50.h,
          color: Colors.blue,
          title: 'Save')
    ],
  );
}
