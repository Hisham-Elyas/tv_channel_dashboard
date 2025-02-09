import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app_color.dart';
import '../../core/helpers/enums.dart';
import '../../responsive.dart';
import '../Categories/controllers/category_controller.dart';
import '../Categories/data/models/category_model.dart';
import '../widget/custom_buttom_widget.dart';
import '../widget/custom_text_form_field_widget.dart';
import '../widget/menu/home_nav_bar.dart';
import 'data/models/channel_model.dart';

class AddChannelToGategory extends StatelessWidget {
  final ChannelModel channel;
  const AddChannelToGategory({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (Responsive.isDesktop(context))
            const HomeNavBar(
              title: "Channels",
              isShowBackButton: true,
            ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 35.w, right: 5.w), //47* - 28*
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
                                    fontSize: 18.sp,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      controller.getAllCategorys();
                                    },
                                    child: const Text("TryAgain"))
                              ],
                            ),
                          )
                        : Form(
                            key: controller.channelformKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  color: AppColor.mainGrey,
                                  child: Text(
                                    " Channels :${channel.name}",
                                    style: TextStyle(
                                        fontSize: Responsive.isMobile(context)
                                            ? 70.sp
                                            : 24.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(height: 10.h),
                                CustomTextFormField(
                                  initialValue: channel.name,
                                  onSaved: (value) =>
                                      controller.channelName = value,
                                  hintText: "Channel Name",
                                ),
                                SizedBox(height: 10.h),
                                // const CustomTextFormField(
                                //   hintText: "Channel Description",
                                //   maxLines: 2,
                                // ),
                                // SizedBox(height: 10.h),
                                // const CustomTextFormField(
                                //   hintText: "Live Url",
                                // ),
                                // SizedBox(height: 10.h),
                                // const CustomTextFormField(
                                //   hintText: "Thumbnail",
                                // ),
                                // SizedBox(height: 10.h),
                                // const CustomTextFormField(
                                //   hintText: "Facebook",
                                // ),
                                // SizedBox(height: 10.h),
                                // const CustomTextFormField(
                                //   hintText: "twitter",
                                // ),
                                // SizedBox(height: 10.h),
                                // const CustomTextFormField(
                                //   hintText: "Website",
                                // ),
                                // SizedBox(height: 10.h),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<Category>(
                                    value: controller.selectedCategory,
                                    hint: const Text("Select a Category"),
                                    isExpanded: true,
                                    items: controller.categorys.map((category) {
                                      return DropdownMenuItem(
                                        value: category,
                                        child: Text(category.name),
                                      );
                                    }).toList(),
                                    onChanged: (Category? newValue) {
                                      controller.selectedCategory = newValue;
                                      controller.update();
                                    },
                                  ),
                                ),

                                SizedBox(height: 10.h),
                                CustomButtom(
                                    height: 88.h,
                                    color: AppColor.mainColor,
                                    onTap: () {
                                      controller.addChannelToCategory(
                                          channel: channel);
                                    },
                                    title: "Submit")
                              ],
                            ),
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
