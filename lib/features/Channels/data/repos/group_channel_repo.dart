import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/helpers/check_internet.dart';
import '../../../../core/helpers/enums.dart';
import '../../../../core/helpers/snackbar_error_message.dart';
import '../../../../core/networking/exception.dart';
import '../models/channel_model.dart';
import '../models/group_channel_model.dart';
import '../remote/group_channel_remote_date.dart';

abstract class GroupChannelRepo {
  Future getAllGroupsChannel();
  Future getAllGroupsChannelById({required String groupId});
}

class GroupChannelRepoImpHttp implements GroupChannelRepo {
  final GroupChannelRemoteDateImplHttp groupChannelRemot;

  GroupChannelRepoImpHttp({required this.groupChannelRemot});
  @override
  Future<Either<StatusRequest, List<GroupChannelModel>>>
      getAllGroupsChannel() async {
    if (await checkInternet()) {
      try {
        final remotData = await groupChannelRemot.getAllGroupsChannel();

        log('from Server  ==>  Get All Groups Channel');

        return right(remotData);
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return left(StatusRequest.serverFailure);
      }
    } else {
      showNetworkError();
      return left(StatusRequest.serverFailure);
    }
  }

  @override
  Future<Either<StatusRequest, List<ChannelModel>>> getAllGroupsChannelById(
      {required String groupId}) async {
    if (await checkInternet()) {
      try {
        final remotData =
            await groupChannelRemot.getAllGroupsChannelById(groupId: groupId);

        log('from Server  ==>  Get All Channel in Grup');

        return right(remotData);
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return left(StatusRequest.serverFailure);
      }
    } else {
      showNetworkError();
      return left(StatusRequest.serverFailure);
    }
  }
}
