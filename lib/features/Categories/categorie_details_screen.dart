import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../app_color.dart';
import '../../responsive.dart';
import '../Channels/video_player_screen.dart';
import '../Channels/video_player_web_screen.dart';
import '../widget/menu/home_nav_bar.dart';
import 'controllers/categorie_details_controller.dart';
import 'data/models/category_whith_channel_model.dart';

class CategorieDetailsScreen extends StatelessWidget {
  final CategoryWithChannels category;
  const CategorieDetailsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            const HomeNavBar(title: "Categories"),
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
                        "${category.categoryName} Categories",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      // const Spacer(),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(Icons.add),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GetBuilder<CategorieDetailsController>(
                    builder: (controller) => LayoutBuilder(
                      builder: (context, constraints) {
                        int columns = constraints.maxWidth > 900
                            ? 5
                            : constraints.maxWidth > 600
                                ? 3
                                : 2;

                        return category.channels.isEmpty
                            ? const Center(
                                child: Text('No Channels available'),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: columns,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 1.5,
                                ),
                                itemCount: category.channels.length,
                                itemBuilder: (context, index) {
                                  return ChannelsCardWidget(
                                      onPressedDelete: () {
                                        controller.removeChannelFromCategory(
                                            channelId:
                                                category.channels[index].id,
                                            categoryId: category.categoryId);
                                      },
                                      channels: category.channels[index]);
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

class ChannelsCardWidget extends StatelessWidget {
  final Channel channels;
  final void Function()? onPressedDelete;
  const ChannelsCardWidget({
    super.key,
    required this.channels,
    this.onPressedDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(Responsive.isMobile(context) ? 5.dm : 8.0.dm),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                channels.customName,
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 45.sp : 16.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Responsive.isMobile(context) ? 2.h : 8.h),
              CachedNetworkImage(
                width: 150.w,
                fit: BoxFit.contain,
                imageUrl: channels.tvgLogo,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Skeletonizer(
                  enableSwitchAnimation: true,
                  enabled: true,
                  child: Skeleton.shade(
                      child: Icon(Icons.live_tv_outlined,
                          size: Responsive.isMobile(context) ? 50.dm : 100.dm)),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              SizedBox(height: Responsive.isMobile(context) ? 0 : 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (kIsWeb) {
                        Get.to(() => VideoPlayerWeb(
                              videoUrl: channels.url,
                            ));
                      } else {
                        Get.to(() => VideoPlayerScreen(
                              videoUrl: channels.url,
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
                  SizedBox(width: 15.w),
                  FittedBox(
                    child: ElevatedButton(
                      onPressed: onPressedDelete,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: Responsive.isMobile(context)
                            ? const Size(70, 25)
                            : null,
                        padding: Responsive.isMobile(context)
                            ? const EdgeInsets.all(0)
                            : null,
                      ),
                      child: Text("Delete",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                Responsive.isMobile(context) ? 45.sp : 16.sp,
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
