import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app_color.dart';
import '../../core/helpers/enums.dart';
import '../../responsive.dart';
import '../Categories/controllers/category_controller.dart';
import '../Categories/data/models/category_whith_channel_model.dart';
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
                                      controller.getAllCategorysWithChannel();
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
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<CategoryWithChannels>(
                                    value: controller.selectedCategory,
                                    hint: const Text("Select a Category"),
                                    isExpanded: true,
                                    items: controller.categorysWithChannel
                                        .map((category) {
                                      return DropdownMenuItem(
                                        value: category,
                                        child: Text(category.categoryName),
                                      );
                                    }).toList(),
                                    onChanged:
                                        (CategoryWithChannels? newValue) {
                                      controller.selectedCategory = newValue;
                                      if (controller.isAddlink) {
                                        controller.isAddlink = false;
                                      }

                                      controller.update();
                                    },
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                SwitchListTile(
                                  title: const Text('add only Link as Quality'),
                                  subtitle: const Text(
                                      'add only Link to Channel in Category (Quality)'),
                                  value: controller.isAddlink,
                                  onChanged: (value) {
                                    controller.isAddlinkSwitch(value);
                                  },
                                ),
                                SizedBox(height: 10.h),
                                Visibility(
                                    visible: controller.isAddlink,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10.h),
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton<Channel>(
                                            value: controller.selectedChannel,
                                            hint:
                                                const Text("Select a Channel"),
                                            isExpanded: true,
                                            items: controller
                                                .channelsOfSelectedCategory
                                                .map((channels) {
                                              return DropdownMenuItem(
                                                value: channels,
                                                child:
                                                    Text(channels.customName),
                                              );
                                            }).toList(),
                                            onChanged: (Channel? newValue) {
                                              controller.selectedChannel =
                                                  newValue;
                                              controller.update();
                                            },
                                          ),
                                        ),
                                      ],
                                    )),
                                SizedBox(height: 40.h),
                                CustomButtom(
                                    height: 88.h,
                                    color: AppColor.mainColor,
                                    onTap: () {
                                      if (controller.isAddlink) {
                                        controller.addLinkeToChannelInCategory(
                                            channel: channel);
                                      } else {
                                        controller.addChannelToCategory(
                                            channel: channel);
                                      }
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
