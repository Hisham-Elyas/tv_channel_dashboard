// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard_tv_channel/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/helpers/enums.dart';
import '../../responsive.dart';
import '../widget/menu/home_nav_bar.dart';
import 'controllers/channel_controller.dart';
import 'data/models/channel_model.dart';
import 'data/models/group_channel_model.dart';
import 'video_player_screen.dart';

class ChannelScreen extends StatelessWidget {
  final GroupChannelModel channel;
  const ChannelScreen({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            HomeNavBar(title: channel.groupTitle),
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
                      Text(
                        "All Channels in ${channel.groupTitle}",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GetBuilder<ChannelsController>(
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
                                          controller.getAllGroupsChannelById(
                                              groupId: channel.id);
                                        },
                                        child: const Text("TryAgain"))
                                  ],
                                ),
                              )
                            : LayoutBuilder(
                                builder: (context, constraints) {
                                  int columns = constraints.maxWidth > 900
                                      ? 4
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
                                    itemCount: controller.channel.length,
                                    itemBuilder: (context, index) {
                                      return ChannelCardWidget(
                                          channel: controller.channel[index]);
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

class ChannelCardWidget extends StatelessWidget {
  final ChannelModel channel;
  const ChannelCardWidget({
    super.key,
    required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    log(channel.tvgLogo);
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(8.0.dm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                channel.name,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CachedNetworkImage(
              width: 150.w,
              height: 150.h,
              fit: BoxFit.contain,
              imageUrl: channel.tvgLogo,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Skeletonizer(
                enableSwitchAnimation: true,
                enabled: true,
                child: Skeleton.shade(
                    child: Icon(Icons.live_tv_outlined, size: 150.dm)),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => VideoPlayerScreen(
                          videoUrl: channel.url,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text("Play"),
                ),
                FittedBox(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text("Add to Gategory"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
