import 'dart:convert';
import 'dart:developer';

import '../../../../core/networking/api_client.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/exception.dart';
import '../models/channel_model.dart';
import '../models/group_channel_model.dart';

abstract class GroupChannelRemoteDate {
  Future getAllGroupsChannel();
  Future getAllGroupsChannelById({required String groupId});
}

class GroupChannelRemoteDateImplHttp implements GroupChannelRemoteDate {
  final ApiClent apiClent;

  GroupChannelRemoteDateImplHttp({required this.apiClent});
  @override
  Future<List<GroupChannelModel>> getAllGroupsChannel() async {
    final resalt = await apiClent.getData(
        uri: ApiConstants.apiBaseUrl + ApiConstants.groupsChannel);
    if (resalt.statusCode == 200) {
      // print(resalt.body);
      final GroupChannelListModel groubpsChannel =
          GroupChannelListModel.fromJson(jsonEncode(resalt.body));
      return groubpsChannel.groups;
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<List<ChannelModel>> getAllGroupsChannelById(
      {required String groupId}) async {
    final resalt = await apiClent.getData(
        // channels/group/
        uri:
            '${ApiConstants.apiBaseUrl}${ApiConstants.channels}${ApiConstants.group}/$groupId');
    if (resalt.statusCode == 200) {
      final ChannelModelListModel channellist =
          ChannelModelListModel.fromJson(resalt.body);
      return channellist.channelModels;
    } else {
      log(resalt.body);
      throw ServerException(message: "${resalt.statusCode}");
    }
  }
}
