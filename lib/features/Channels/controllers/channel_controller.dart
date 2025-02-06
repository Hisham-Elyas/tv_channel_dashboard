import 'package:get/get.dart';

import '../../../core/helpers/enums.dart';
import '../data/models/channel_model.dart';
import '../data/repos/group_channel_repo.dart';

class ChannelsController extends GetxController {
  late StatusRequest statusReq;
  List<ChannelModel> channel = [];
  final GroupChannelRepoImpHttp groupChannelRepo = Get.find();

  Future<void> getAllGroupsChannelById({required int groupId}) async {
    statusReq = StatusRequest.loading;
    update();
    final resalt = await groupChannelRepo.getAllGroupsChannelById(
        groupId: groupId.toString());
    resalt.fold((l) {
      statusReq = l;
      update();
    }, (r) {
      channel = r;
      statusReq = StatusRequest.success;
      update();
    });
  }
}
