import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helpers/coustom_overlay.dart';
import '../data/repos/category_repo.dart';
import 'category_controller.dart';

class CreateCategoryController extends GetxController {
  final GlobalKey<FormState> categoryformKey = GlobalKey();
  late String categoryName;
  final CategoryRepoImpHttp categoryRepo = Get.find();
  final     CategoryController categoryController = Get.find();
  // late StatusRequest statusReq;

  Future<void> createCategory() async {
    Get.focusScope!.unfocus();
    if (!categoryformKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    categoryformKey.currentState!.save();

    late bool resalt;
    update();
    showOverlay(
      asyncFunction: () async {
        resalt = await categoryRepo.createCategory(name: categoryName);
        if (resalt == true) {
    
          categoryController.getAllCategorysWithChannel();
          Get.back();
        }
      },
    );
  }

  Future<void> updateCategory({required int categoryId}) async {
    Get.focusScope!.unfocus();
    if (!categoryformKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    categoryformKey.currentState!.save();

    late bool resalt;
    update();
    showOverlay(
      asyncFunction: () async {
        resalt = await categoryRepo.updateCategory(
            categoryId: categoryId, newName: categoryName);
        if (resalt == true) {
          categoryController.getAllCategorysWithChannel();
          Get.back();
        }
      },
    );
  }

  String? categoryNamevalidator(val) {
    if (val.isEmpty) {
      return "Type_your_Category_Name".tr;
    } else {
      return null;
    }
  }

  set setCategoryName(val) {
    categoryName = val;
  }
}
