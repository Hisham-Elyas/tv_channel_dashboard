import 'package:get/get.dart';

import 'features/Categories/categories_screen.dart';
import 'features/Channels/group_of_channel_screen.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/login/login_screen.dart';
import 'features/sittings/sittings_screen.dart';

class PagesController extends GetxController {
  final List screen = [
    const DashboardScreen(),
    GroupOfChannelScreen(),
    CategoriesScreen(),
    const SittingsScreen(),
  ];
  int pageNum = 0;
  goToPage(int page) {
    if (page > screen.length - 1) {
      Get.offAll(() => const LoginScreen());
    } else {
      pageNum = page;
      update();
    }
  }
}
