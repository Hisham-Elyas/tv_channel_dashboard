import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app_color.dart';
import '../responsive.dart';
import '../widget/menu/home_nav_bar.dart';
import 'add_category_screen.dart';

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
                          return CategoriesCardWidget(title: titles[index]);
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

class CategoriesCardWidget extends StatelessWidget {
  final String title;
  const CategoriesCardWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
