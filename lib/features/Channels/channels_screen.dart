// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard_tv_channel/app_color.dart';
import 'package:flutter/foundation.dart';
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
import 'video_player_web_screen.dart';

class ChannelScreen extends StatelessWidget {
  final GroupChannelModel channel;
  const ChannelScreen({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                        FittedBox(
                          child: Text(
                            "All Channels in ${channel.groupTitle}",
                            style: TextStyle(
                                fontSize: Responsive.isMobile(context)
                                    ? 70.sp
                                    : 24.sp,
                                fontWeight: FontWeight.bold),
                          ),
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
                                          fontSize: Responsive.isMobile(context)
                                              ? 50.sp
                                              : 18.sp,
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
    // log(channel.tvgLogo);
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(Responsive.isMobile(context) ? 5.dm : 8.0.dm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                channel.name,
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 45.sp : 16.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            channel.tvgName.startsWith('#')
                ? Text(
                    "TV Group",
                    style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 45.sp : 16.sp),
                  )
                : CachedNetworkImage(
                    width: 150.w,
                    // height: 150.h,
                    fit: BoxFit.contain,
                    imageUrl: channel.tvgLogo,

                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Skeletonizer(
                      enableSwitchAnimation: true,
                      enabled: true,
                      child: Skeleton.shade(
                          child: Icon(Icons.live_tv_outlined, size: 50.dm)),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
            channel.tvgName.startsWith('#')
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // print(channel.toString());
                          // return;
                          if (kIsWeb) {
                            Get.to(() => VideoPlayerWeb(
                                  videoUrl: channel.url,
                                ));
                          } else {
                            Get.to(() => VideoPlayerScreen(
                                  videoUrl: channel.url,
                                ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Responsive.isMobile(context)
                              ? const Size(70, 25)
                              : null,
                          padding: Responsive.isMobile(context)
                              ? const EdgeInsets.all(0)
                              : null,
                        ),
                        child: Text("Play",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  Responsive.isMobile(context) ? 45.sp : 16.sp,
                            )),
                      ),
                      FittedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            // Get.to(() => AddChannelToGategory(
                            //       channel: channel,
                            //     ));
                            print(channel.toString());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            minimumSize: Responsive.isMobile(context)
                                ? const Size(70, 25)
                                : null,
                            padding: Responsive.isMobile(context)
                                ? const EdgeInsets.all(0)
                                : null,
                          ),
                          child: Text("Add to Gategory",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Responsive.isMobile(context)
                                    ? 35.sp
                                    : 16.sp,
                              )),
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
