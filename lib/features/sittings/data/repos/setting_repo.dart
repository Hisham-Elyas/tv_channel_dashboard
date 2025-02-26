import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/helpers/check_internet.dart';
import '../../../../core/helpers/enums.dart';
import '../../../../core/helpers/snackbar_error_message.dart';
import '../../../../core/networking/exception.dart';
import '../models/iptv_config_model.dart';
import '../remote/setting_remote_data.dart';

abstract class SettingRepo {
  addIptvConfigSettingsUser({required IptvConfig iptvConfig});
  getAllIptvConfigSttingsUser();
  setAllowUseIptvConfigSttingsUser({required String id});
}

class SettingRepoImpHttp implements SettingRepo {
  final SettingsRemoteDataImplHttp settingRemoteData;

  SettingRepoImpHttp({required this.settingRemoteData});
  @override
  Future<bool> addIptvConfigSettingsUser(
      {required IptvConfig iptvConfig}) async {
    if (await checkInternet()) {
      try {
        final remotData = await settingRemoteData.addIptvConfigSettingsUser(
            iptvConfig: iptvConfig);

        log('from Server  ==>  add Iptv Config Settings User');

        return remotData;
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return false;
      }
    } else {
      showNetworkError();
      return false;
    }
  }

  @override
  Future<Either<StatusRequest, List<IptvConfig>>>
      getAllIptvConfigSttingsUser() async {
    if (await checkInternet()) {
      try {
        final remotData = await settingRemoteData.getAllIptvConfigSttingsUser();

        log('from Server  ==>  Get All Iptv Config Sttings User');

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
  Future<bool> setAllowUseIptvConfigSttingsUser({required String id}) async {
    if (await checkInternet()) {
      try {
        final remotData =
            await settingRemoteData.setAllowUseIptvConfigSttingsUser(id: id);

        log('from Server  ==>  set Allow Use IptvConfig Sttings User');

        return remotData;
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return false;
      }
    } else {
      showNetworkError();
      return false;
    }
  }
}
