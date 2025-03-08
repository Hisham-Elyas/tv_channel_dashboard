// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app_color.dart';
import '../../core/helpers/enums.dart';
import '../../responsive.dart';
import '../widget/menu/home_nav_bar.dart';
import 'add_category_screen.dart';
import 'categorie_details_screen.dart';
import 'controllers/category_controller.dart';
import 'data/models/category_whith_channel_model.dart';
import 'edit_category_screen.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});
  final titles = [
    "Sports",
    "News",
    "Entertainment",
  ];
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
                      const Text(
                        "All Categories",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Get.to(() => const AddCategoryScreen());
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GetBuilder<CategoryController>(
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
                                          controller
                                              .getAllCategorysWithChannel();
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
                                        controller.categorysWithChannel.length,
                                    itemBuilder: (context, index) {
                                      return CategoriesCardWidget(
                                          onPressedEdit: () {
                                            Get.to(() => EditCategoryScreen(
                                                  categoryId: controller
                                                      .categorysWithChannel[
                                                          index]
                                                      .categoryId,
                                                  categoryName: controller
                                                      .categorysWithChannel[
                                                          index]
                                                      .categoryName,
                                                ));
                                          },
                                          onPressedDelete: () {
                                            controller.deleteCategory(
                                                categoryId: controller
                                                    .categorysWithChannel[index]
                                                    .categoryId);
                                          },
                                          onTap: () {
                                            // CategorieDetailsController
                                            //     categorieDetailsController =
                                            //     Get.find();
                                            // categorieDetailsController
                                            //     .getAllchannelsInCategorys(
                                            //         categoryId: controller
                                            //             .categorysWithChannel[
                                            //                 index]
                                            //             .categoryId);

                                            Get.to(() => CategorieDetailsScreen(
                                                category: controller
                                                        .categorysWithChannel[
                                                    index]));
                                          },
                                          category: controller
                                              .categorysWithChannel[index]);
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

class CategoriesCardWidget extends StatelessWidget {
  final CategoryWithChannels category;
  final void Function()? onTap;
  final void Function()? onPressedDelete;
  final void Function()? onPressedEdit;
  const CategoriesCardWidget({
    super.key,
    required this.category,
    this.onTap,
    this.onPressedDelete,
    this.onPressedEdit,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(Responsive.isMobile(context) ? 7.dm : 8.0.dm),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category.categoryName,
                  style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 65.sp : 16.sp,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  category.channels.length.toString(),
                  style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 80.sp : 28,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Responsive.isMobile(context) ? 5.h : 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: ElevatedButton(
                        onPressed: onPressedEdit,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Responsive.isMobile(context)
                              ? const Size(70, 25)
                              : null,
                          padding: Responsive.isMobile(context)
                              ? const EdgeInsets.all(0)
                              : null,
                          backgroundColor: Colors.blue,
                        ),
                        child: Text("Edit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  Responsive.isMobile(context) ? 45.sp : 16.sp,
                            )),
                      ),
                    ),
                    SizedBox(width: Responsive.isMobile(context) ? 10.h : 20.h),
                    FittedBox(
                      child: ElevatedButton(
                        onPressed: onPressedDelete,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Responsive.isMobile(context)
                              ? const Size(70, 25)
                              : null,
                          padding: Responsive.isMobile(context)
                              ? const EdgeInsets.all(0)
                              : null,
                          backgroundColor: Colors.red,
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
      ),
    );
  }
}
