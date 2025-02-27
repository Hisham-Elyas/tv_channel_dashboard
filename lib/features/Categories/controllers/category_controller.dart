import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helpers/coustom_overlay.dart';
import '../../../core/helpers/enums.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../Channels/data/models/channel_model.dart';
// import '../data/models/category_channels_model.dart';
// import '../data/models/category_model.dart';
import '../data/models/category_whith_channel_model.dart';
import '../data/repos/category_repo.dart';
import 'categorie_details_controller.dart';

class CategoryController extends GetxController {
  final CategoryRepoImpHttp categoryRepo = Get.find();
  final GlobalKey<FormState> channelformKey = GlobalKey();
  CategorieDetailsController categorieDetailsController = Get.find();

  bool isAddlink = false;

  late StatusRequest statusReq;
  CategoryWithChannels? selectedCategory;
  Channel? selectedChannel;
  String? channelName;
  List<Channel> channelsOfSelectedCategory = [];
  // List<Category> categorys = [];

  List<CategoryWithChannels> categorysWithChannel = [];
  CategoryWithChannels get getCategoryById {
    if (selectedCategory == null) return categorysWithChannel.first;
    return categorysWithChannel.firstWhere(
        (element) => element.categoryId == selectedCategory?.categoryId);
  }

  @override
  void onInit() {
    // getAllCategorys();
    getAllCategorysWithChannel();
    super.onInit();
  }

  Future<void> getAllCategorysWithChannel() async {
    statusReq = StatusRequest.loading;
    update();
    final resalt = await categoryRepo.getAllCategorywithChannel();
    resalt.fold((l) {
      statusReq = l;
      update();
    }, (r) {
      categorysWithChannel = r;
      statusReq = StatusRequest.success;
      update();
    });
  }

  isAddlinkSwitch(val) {
    if (selectedCategory == null) {
      showCustomSnackBar(
          message: "Please select a category.".tr,
          title: "Add Link to Channel In Category".tr,
          isError: true);
      return;
    }
    // categorieDetailsController.getAllchannelsInCategorys(
    //     categoryId: selectedCategory!.categoryId);
    isAddlink = val;
    channelsOfSelectedCategory = categorysWithChannel
        .firstWhere(
            (element) => element.categoryId == selectedCategory!.categoryId)
        .channels;
    if (!channelsOfSelectedCategory.contains(selectedChannel)) {
      selectedChannel = channelsOfSelectedCategory.isNotEmpty
          ? channelsOfSelectedCategory.first
          : null;
    }
    update();
  }

  // Future<void> getAllCategorys() async {
  //   statusReq = StatusRequest.loading;
  //   update();
  //   final resalt = await categoryRepo.getAllCategory();
  //   resalt.fold((l) {
  //     statusReq = l;
  //     update();
  //   }, (r) {
  //     categorys = r;
  //     statusReq = StatusRequest.success;
  //     update();
  //   });
  // }

  Future<void> addChannelToCategory({required ChannelModel channel}) async {
    Get.focusScope!.unfocus();
    if (!channelformKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    channelformKey.currentState!.save();
    if (selectedCategory == null) {
      showCustomSnackBar(
          message: "Please select a category.".tr,
          title: "Add Channel To Category".tr,
          isError: true);
      return;
    }
    late bool resalt;
    await showOverlay(
      asyncFunction: () async {
        resalt = await categoryRepo.addChannelToCategory(
            categoryId: selectedCategory!.categoryId,
            channelId: channel.id,
            channelName: channelName!);
      },
    );
    if (resalt == true) {
      Get.back();
      selectedCategory = null;
      channelName = null;
      isAddlink = false;
      channelsOfSelectedCategory = [];

      showCustomSnackBar(
        message:
            "Successfully Add $channelName To ${selectedCategory!.categoryName} ✅"
                .tr,
        title: "Add Channel To Category".tr,
      );
      await getAllCategorysWithChannel();
    }
  }

  Future<void> addLinkeToChannelInCategory(
      {required ChannelModel channel}) async {
    Get.focusScope!.unfocus();
    if (!channelformKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    channelformKey.currentState!.save();
    if (selectedCategory == null) {
      showCustomSnackBar(
          message: "Please select a category.".tr,
          title: "Add Channel To Category".tr,
          isError: true);
      return;
    }
    late bool resalt;
    await showOverlay(
      asyncFunction: () async {
        resalt = await categoryRepo.addLinkeToChannelInCategory(
            categoryId: selectedCategory!.categoryId,
            channelId: selectedChannel!.id,
            linkName: channelName!,
            linkUrl: channel.url);
      },
    );
    if (resalt == true) {
      Get.back();
      showCustomSnackBar(
        message: "Successfully Add $channelName Link ✅".tr,
        title: "Add Link to Channel In Category".tr,
      );
      selectedCategory = null;
      channelName = null;
      isAddlink = false;
      channelsOfSelectedCategory = [];
      await getAllCategorysWithChannel();
    }
  }

  Future<void> deleteCategory({required int categoryId}) async {
    late bool resalt;
    await showOverlay(
      asyncFunction: () async {
        resalt = await categoryRepo.deleteCategory(categoryId: categoryId);
      },
    );
    if (resalt == true) {
      getAllCategorysWithChannel();
    }
  }

  String? channelNamevalidator(val) {
    if (val.isEmpty) {
      return "Type_your_channel_Name".tr;
    } else if (val.length < 4) {
      return "channel_can_not_be_less_than_4_characters".tr;
    } else {
      return null;
    }
  }

  set setchannelName(val) {
    channelName = val;
  }
}
