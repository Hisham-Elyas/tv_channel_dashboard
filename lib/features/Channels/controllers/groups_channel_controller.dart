import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helpers/enums.dart';
import '../data/models/group_channel_model.dart';
import '../data/repos/group_channel_repo.dart';

class GroupsChannelController extends GetxController {
  final TextEditingController searchController = TextEditingController();
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
      filteredGroups = r;
      statusReq = StatusRequest.success;
      update();
    });
  }

  List<GroupChannelModel> filteredGroups = [];
  void filterGroups(String query) {
    if (query.isEmpty) {
      filteredGroups = groupsChannel;
      update();
    } else {
      filteredGroups = groupsChannel
          .where((group) =>
              group.groupTitle.toLowerCase().contains(query.toLowerCase()))
          .toList();
      update();
    }
  }
}
