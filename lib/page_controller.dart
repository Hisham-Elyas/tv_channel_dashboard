import 'package:get/get.dart';
import 'Categories/categories_screen.dart';
import 'dashboard/dashboard_screen.dart';

import 'Channels/channel_screen.dart';
import 'login/login_screen.dart';
import 'sittings/sittings_screen.dart';

class PagesController extends GetxController {
  final List screen = [
    const DashboardScreen(),
    ChannelScreen(),
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
