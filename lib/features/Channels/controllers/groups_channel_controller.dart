import 'package:get/get.dart';

import '../../../core/helpers/enums.dart';
import '../data/models/group_channel_model.dart';
import '../data/repos/group_channel_repo.dart';

class GroupsChannelController extends GetxController {
  late StatusRequest statusReq;
  List<GroupChannelModel> groupsChannel = [];
  final GroupChannelRepoImpHttp groupChannelRepo = Get.find();

  @override
  void onInit() {
    getAllGroupsChannel();
    super.onInit();
  }

  Future<void> getAllGroupsChannel() async {
    statusReq = StatusRequest.loading;
    update();
    final resalt = await groupChannelRepo.getAllGroupsChannel();
    resalt.fold((l) {
      statusReq = l;
      update();
    }, (r) {
      groupsChannel = r;
      statusReq = StatusRequest.success;
      update();
    });
  }
}
