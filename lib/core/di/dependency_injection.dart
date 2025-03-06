import 'package:get/get.dart';

import '../../features/Categories/controllers/categorie_details_controller.dart';
import '../../features/Categories/controllers/category_controller.dart';
import '../../features/Categories/controllers/create_category_controller.dart';
import '../../features/Categories/data/remote/category_channel_remote_data.dart';
import '../../features/Categories/data/repos/category_repo.dart';
import '../../features/Channels/controllers/channel_controller.dart';
import '../../features/Channels/controllers/groups_channel_controller.dart';
import '../../features/Channels/data/remote/group_channel_remote_date.dart';
import '../../features/Channels/data/repos/group_channel_repo.dart';
import '../../features/sittings/controllers/setting_controller.dart';
import '../../features/sittings/data/remote/setting_remote_data.dart';
import '../../features/sittings/data/repos/setting_repo.dart';
import '../../page_controller.dart';
import '../networking/api_client.dart';

Future init() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // firebaseAuth.authStateChanges().listen((User? user) {
  //   if (user != null) {
  //     log(" User is login by ${user.uid}");
  //     log(" User is login by ${user.email}");
  //   } else {
  //     log("............... not User is login ");
  //   }
  // });
}

Future<void> setupGetIt() async {
  await init();

  ///  api client
  Get.lazyPut(() => ApiClent(), fenix: true);
  Get.lazyPut(() => PagesController(), fenix: true);
  /////
  Get.lazyPut(() => GroupChannelRemoteDateImplHttp(apiClent: Get.find()),
      fenix: true);
  Get.lazyPut(() => GroupChannelRepoImpHttp(groupChannelRemot: Get.find()),
      fenix: true);
  Get.lazyPut(() => GroupsChannelController(), fenix: true);
  Get.lazyPut(() => ChannelsController(), fenix: true);

  ////

  Get.lazyPut(() => CategoryRemoteDateImplHttp(apiClent: Get.find()),
      fenix: true);
  Get.lazyPut(() => CategoryRepoImpHttp(categoryRemote: Get.find()),
      fenix: true);
  Get.lazyPut(() => CategoryController(), fenix: true);
  Get.lazyPut(() => CategorieDetailsController(), fenix: true);
  Get.lazyPut(() => CreateCategoryController(), fenix: true);

  Get.lazyPut(() => SettingController(), fenix: true);
  Get.lazyPut(() => SettingsRemoteDataImplHttp(apiClent: Get.find()),
      fenix: true);
  Get.lazyPut(() => SettingRepoImpHttp(settingRemoteData: Get.find()),
      fenix: true);

  Get.put(CategoryController());
  Get.put(CategorieDetailsController());
  Get.put(PagesController());
  Get.put(GroupsChannelController());
  Get.put(SettingController());
}
