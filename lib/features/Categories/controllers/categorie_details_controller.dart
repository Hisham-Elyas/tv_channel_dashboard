import 'package:dashboard_tv_channel/features/Categories/data/models/category_whith_channel_model.dart';
import 'package:get/get.dart';

import '../../../core/helpers/coustom_overlay.dart';
import '../../../core/helpers/enums.dart';
import '../data/repos/category_repo.dart';
import 'category_controller.dart';

class CategorieDetailsController extends GetxController {
  final CategoryRepoImpHttp categoryRepo = Get.find();

  final CategoryController categoryController = Get.find();
  late StatusRequest statusReq;
  // List<Channel> channels = [];
  // late CategoryChannels categoryChannels;

  // Future<void> getAllchannelsInCategorys({required int categoryId}) async {
  //   statusReq = StatusRequest.loading;
  //   update();
  //   final resalt =
  //       await categoryRepo.getAllChannelInCategoryById(categoryId: categoryId);
  //   resalt.fold((l) {
  //     statusReq = l;
  //     update();
  //   }, (r) {
  //     categoryChannels = r;
  //     channels = r.channels;
  //     statusReq = StatusRequest.success;
  //     update();
  //   });
  // }

  Future<void> removeLinkInChannelInCategory(
      {required int categoryId,
      required String linkUrl,
      required Channel channels}) async {
    late bool resalt;
    Get.back();
    await showOverlay(
      asyncFunction: () async {
        resalt = await categoryRepo.removeLinkInChannelInCategory(
            categoryId: categoryId, channelId: channels.id, linkUrl: linkUrl);
        if (resalt == true) {
          Get.back();
          categoryController.getAllCategorysWithChannel();
          Get.snackbar("Deleted", "Channel removed successfully");
        } else {
          Get.snackbar("Error", "Failed to delete channel");
        }
      },
    );
  }

  Future<void> removeChannelFromCategory(
      {required int categoryId, required int channelId}) async {
    late bool resalt;
    await showOverlay(
      asyncFunction: () async {
        resalt = await categoryRepo.removeChannelFromCategory(
            categoryId: categoryId, channelId: channelId);
        if (resalt == true) {
          Get.back();
          categoryController.getAllCategorysWithChannel();
        }
      },
    );
  }
}
