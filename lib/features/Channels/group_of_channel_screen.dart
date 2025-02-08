// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dashboard_tv_channel/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/helpers/enums.dart';
import '../../responsive.dart';
import '../widget/menu/home_nav_bar.dart';
import 'channels_screen.dart';
import 'controllers/channel_controller.dart';
import 'controllers/groups_channel_controller.dart';
import 'data/models/group_channel_model.dart';

class GroupOfChannelScreen extends StatelessWidget {
  GroupOfChannelScreen({super.key});
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
                          // Get.to(() => const GroupChannelCardWidget(
                          //     title: 'Add'));
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GetBuilder<GroupsChannelController>(
                    builder: (controller) => controller.statusReq ==
                            StatusRequest.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : controller.statusReq == StatusRequest.serverFailure
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Please_try_agein_later",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          controller.getAllGroupsChannel();
                                        },
                                        child: const Text("TryAgain"))
                                  ],
                                ),
                              )
                            : LayoutBuilder(
                                builder: (context, constraints) {
                                  int columns = constraints.maxWidth > 900
                                      ? 5
                                      : constraints.maxWidth > 600
                                          ? 3
                                          : 1;

                                  return GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: columns,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      childAspectRatio: 1.5,
                                    ),
                                    itemCount: controller.groupsChannel.length,
                                    itemBuilder: (context, index) {
                                      return GroupChannelCardWidget(
                                          onTap: () {
                                            ChannelsController
                                                channelsController = Get.find();
                                            channelsController
                                                .getAllGroupsChannelById(
                                                    groupId: controller
                                                        .groupsChannel[index]
                                                        .id);
                                            Get.to(() => ChannelScreen(
                                                channel: controller
                                                    .groupsChannel[index]));
                                          },
                                          groupChannel:
                                              controller.groupsChannel[index]);
                                    },
                                  );
                                },
                              ),
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

class GroupChannelCardWidget extends StatelessWidget {
  final GroupChannelModel groupChannel;

  final void Function()? onTap;

  const GroupChannelCardWidget({
    super.key,
    required this.groupChannel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0.dm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                groupChannel.groupTitle,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              groupChannel.channels.toString(),
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text("View all ",
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
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
                    // Get.to(() =>
                    //     const AddandEditGroupOfChannelScreen(title: 'Edit'));
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
