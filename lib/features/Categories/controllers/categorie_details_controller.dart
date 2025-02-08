import 'package:get/get.dart';

import '../../../core/helpers/coustom_overlay.dart';
import '../../../core/helpers/enums.dart';
import '../data/models/category_channels_model.dart';
import '../data/repos/category_repo.dart';

class CategorieDetailsController extends GetxController {
  final CategoryRepoImpHttp categoryRepo = Get.find();
  late StatusRequest statusReq;
  List<Channel> channels = [];
  late CategoryChannels categoryChannels;

  Future<void> getAllchannelsInCategorys({required int categoryId}) async {
    statusReq = StatusRequest.loading;
    update();
    final resalt =
        await categoryRepo.getAllChannelInCategoryById(categoryId: categoryId);
    resalt.fold((l) {
      statusReq = l;
      update();
    }, (r) {
      categoryChannels = r;
      channels = r.channels;
      statusReq = StatusRequest.success;
      update();
    });
  }

  Future<void> removeChannelFromCategory(
      {required int categoryId, required int channelId}) async {
    late bool resalt;
    await showOverlay(
      asyncFunction: () async {
        resalt = await categoryRepo.removeChannelFromCategory(
            categoryId: categoryId, channelId: channelId);
        if (resalt == true) {
          getAllchannelsInCategorys(categoryId: categoryId);
        }
      },
    );
  }
}
