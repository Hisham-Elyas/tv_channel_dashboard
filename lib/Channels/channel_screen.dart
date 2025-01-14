// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dashboard_tv_channel/Channels/add_edit_channel_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dashboard_tv_channel/app_color.dart';
import 'package:get/get.dart';

import '../responsive.dart';
import '../widget/menu/home_nav_bar.dart';

class ChannelScreen extends StatelessWidget {
  ChannelScreen({super.key});
  final titles = [
    "Whistle Sports",
    "BEIN SPORTS EXTRA",
    "FOX SPORTS",
    "Whistle Sports",
    "BEIN SPORTS EXTRA",
    "FOX SPORTS"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            const HomeNavBar(title: "Channels"),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 35.w, right: 5.w), //47* - 28*
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  color: AppColor.mainGrey,
                  child: Row(
                    children: [
                      const Text(
                        "All Channels",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Get.to(() =>
                              const AddandEditChannelScreen(title: 'Add'));
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      int columns = constraints.maxWidth > 900
                          ? 3
                          : constraints.maxWidth > 600
                              ? 2
                              : 1;

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.5,
                        ),
                        itemCount: titles.length,
                        itemBuilder: (context, index) {
                          return ChannelCardWidget(title: titles[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class ChannelCardWidget extends StatelessWidget {
  final String title;
  const ChannelCardWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text("Play"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Delete"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const AddandEditChannelScreen(title: 'Edit'));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: const Text("Edit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
