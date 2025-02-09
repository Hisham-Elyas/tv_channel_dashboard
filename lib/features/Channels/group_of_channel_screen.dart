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
            child: GetBuilder<GroupsChannelController>(
              builder: (controller) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    color: AppColor.mainGrey,
                    child: const Row(
                      children: [
                        Text(
                          "All Group Of Channels",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),

                        Spacer(),

                        // IconButton(
                        //   onPressed: () {
                        //     // Get.to(() => const GroupChannelCardWidget(
                        //     //     title: 'Add'));
                        //   },
                        //   icon: const Icon(Icons.add),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.h),
                    child: TextField(
                      controller: controller.searchController,
                      onChanged: controller.filterGroups,
                      decoration: InputDecoration(
                        hintText: "Search...",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                      child: controller.statusReq == StatusRequest.loading
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
                                            : 2;

                                    return GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: columns,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16,
                                        childAspectRatio: 1.5,
                                      ),
                                      itemCount:
                                          controller.filteredGroups.length,
                                      itemBuilder: (context, index) {
                                        return GroupChannelCardWidget(
                                            onTap: () {
                                              ChannelsController
                                                  channelsController =
                                                  Get.find();
                                              channelsController
                                                  .getAllGroupsChannelById(
                                                      groupId: controller
                                                          .filteredGroups[index]
                                                          .id);
                                              Get.to(() => ChannelScreen(
                                                  channel: controller
                                                      .filteredGroups[index]));
                                            },
                                            groupChannel: controller
                                                .filteredGroups[index]);
                                      },
                                    );
                                  },
                                )),
                ],
              ),
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
        padding: EdgeInsets.all(Responsive.isMobile(context) ? 5.h : 16.0.dm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                groupChannel.groupTitle,
                style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 70.sp : 16.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: Responsive.isMobile(context) ? 0.h : 8.h),
            Text(
              groupChannel.channels.toString(),
              style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 60.sp : 16.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: Responsive.isMobile(context) ? 0.h : 16.h),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                // fixedSize: const Size(20, 5),
                minimumSize:
                    Responsive.isMobile(context) ? const Size(70, 25) : null,
                padding: Responsive.isMobile(context)
                    ? const EdgeInsets.all(0)
                    : null,
                backgroundColor: Colors.red,
              ),
              child: Text("View all ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Responsive.isMobile(context) ? 50.sp : 16.sp,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
