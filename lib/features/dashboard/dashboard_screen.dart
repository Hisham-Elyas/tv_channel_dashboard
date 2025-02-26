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
                      ? 5
                      : constraints.maxWidth > 600
                          ? 3
                          : 2;

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
                                              fontSize:
                                                  Responsive.isMobile(context)
                                                      ? 50.sp
                                                      : 18.sp,
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
                                                      .getAllCategorysWithChannel();
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
                                                        .getAllCategorysWithChannel();
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
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16,
                                        childAspectRatio: 1.5,
                                      ),
                                      itemCount: 2,
                                      itemBuilder: (context, index) {
                                        final titles = [
                                          "Groups Channel",
                                          "Categories",
                                          // "Users"
                                        ];
                                        final counts = [
                                          groupsChannelController
                                              .groupsChannel.length
                                              .toString(),
                                          categoryController
                                              .categorysWithChannel.length
                                              .toString(),
                                          // "5437"
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
        padding: EdgeInsets.all(Responsive.isMobile(context) ? 5.dm : 8.0.dm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 45.sp : 16.sp,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              count,
              style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 80.sp : 28,
                  fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize:
                    Responsive.isMobile(context) ? const Size(70, 25) : null,
                padding: Responsive.isMobile(context)
                    ? const EdgeInsets.all(0)
                    : null,
              ),
              child: Text("View all",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Responsive.isMobile(context) ? 45.sp : 16.sp,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
