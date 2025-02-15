import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/helpers/enums.dart';
import '../../page_controller.dart';
import '../../responsive.dart';
import '../Categories/controllers/category_controller.dart';
import '../Channels/controllers/groups_channel_controller.dart';
import '../widget/menu/home_nav_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            const HomeNavBar(title: "Dashboard"),
          SizedBox(height: 16.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.dm),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Determine the number of columns based on screen width
                  int columns = constraints.maxWidth > 900
                      ? 3
                      : constraints.maxWidth > 600
                          ? 2
                          : 1;

                  return GetBuilder<CategoryController>(
                    builder: (categoryController) =>
                        GetBuilder<GroupsChannelController>(
                      builder: (groupsChannelController) =>
                          (groupsChannelController.statusReq ==
                                      StatusRequest.loading ||
                                  categoryController.statusReq ==
                                      StatusRequest.loading)
                              ? const Center(child: CircularProgressIndicator())
                              : (groupsChannelController.statusReq ==
                                          StatusRequest.serverFailure ||
                                      categoryController.statusReq ==
                                          StatusRequest.serverFailure)
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                // Check if both category and groupsChannel have failed
                                                if (groupsChannelController
                                                            .statusReq ==
                                                        StatusRequest
                                                            .serverFailure &&
                                                    categoryController
                                                            .statusReq ==
                                                        StatusRequest
                                                            .serverFailure) {
                                                  categoryController
                                                      .getAllCategorys();
                                                  groupsChannelController
                                                      .getAllGroupsChannel();
                                                } else {
                                                  // Handle individual failures
                                                  if (groupsChannelController
                                                          .statusReq ==
                                                      StatusRequest
                                                          .serverFailure) {
                                                    groupsChannelController
                                                        .getAllGroupsChannel();
                                                  }
                                                  if (categoryController
                                                          .statusReq ==
                                                      StatusRequest
                                                          .serverFailure) {
                                                    categoryController
                                                        .getAllCategorys();
                                                  }
                                                }
                                              },
                                              child: const Text("TryAgain"))
                                        ],
                                      ),
                                    )
                                  : GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: columns,
                                        crossAxisSpacing: 2,
                                        mainAxisSpacing: 2,
                                      ),
                                      itemCount: 3,
                                      itemBuilder: (context, index) {
                                        final titles = [
                                          "Groups Channel",
                                          "Categories",
                                          "Users"
                                        ];
                                        final counts = [
                                          groupsChannelController
                                              .groupsChannel.length
                                              .toString(),
                                          categoryController.categorys.length
                                              .toString(),
                                          "5437"
                                        ];
                                        return DashboardCardWidget(
                                          title: titles[index],
                                          count: counts[index],
                                          onTap: () {
                                            PagesController pagesController =
                                                Get.find();
                                            if (index == 0) {
                                              pagesController.goToPage(1);
                                            } else if (index == 1) {
                                              pagesController.goToPage(2);
                                            }
                                          },
                                        );
                                      },
                                    ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardCardWidget extends StatelessWidget {
  final String title;
  final String count;
  final void Function()? onTap;

  const DashboardCardWidget({
    super.key,
    required this.title,
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              count,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child:
                  const Text("View all", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
