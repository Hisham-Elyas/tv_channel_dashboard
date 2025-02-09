import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helpers/coustom_overlay.dart';
import '../../../core/helpers/enums.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../Channels/data/models/channel_model.dart';
import '../data/models/category_model.dart';
import '../data/repos/category_repo.dart';

class CategoryController extends GetxController {
  final CategoryRepoImpHttp categoryRepo = Get.find();
  final GlobalKey<FormState> channelformKey = GlobalKey();

  late StatusRequest statusReq;
  Category? selectedCategory;
  String? channelName;
  List<Category> categorys = [];

  @override
  void onInit() {
    getAllCategorys();
    super.onInit();
  }

  Future<void> getAllCategorys() async {
    statusReq = StatusRequest.loading;
    update();
    final resalt = await categoryRepo.getAllCategory();
    resalt.fold((l) {
      statusReq = l;
      update();
    }, (r) {
      categorys = r;
      statusReq = StatusRequest.success;
      update();
    });
  }

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
            categoryId: selectedCategory!.id,
            channelId: channel.id,
            channelName: channelName!);
      },
    );
    if (resalt == true) {
      Get.back();
      showCustomSnackBar(
        message:
            "Successfully Add $channelName To ${selectedCategory!.name} ✅".tr,
        title: "Add Channel To Category".tr,
      );
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
      getAllCategorys();
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
