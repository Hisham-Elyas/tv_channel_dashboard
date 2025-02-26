import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_color.dart';
import 'features/widget/menu/home_nav_bar.dart';
import 'features/widget/menu/home_side_bar_menu_section.dart';
import 'page_controller.dart';
import 'responsive.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Responsive.isDesktop(context)
            ? null
            : AppBar(
                backgroundColor: AppColor.backgroundColor,
                title: const HomeNavBar(title: ""),
              ),
        drawer: SideMenuSection(),
        body: SafeArea(
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (Responsive.isDesktop(context))
              Expanded(flex: 2, child: SideMenuSection()),
            GetBuilder<PagesController>(
                builder: (controller) => Expanded(
                    flex: 8, child: controller.screen[controller.pageNum]))
          ]),
        ));
  }
}
