import 'package:get/get.dart';

import '../../../core/helpers/coustom_overlay.dart';
import '../../../core/helpers/enums.dart';
import '../data/models/category_model.dart';
import '../data/repos/category_repo.dart';

class CategoryController extends GetxController {
  final CategoryRepoImpHttp categoryRepo = Get.find();
  late StatusRequest statusReq;
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
}
