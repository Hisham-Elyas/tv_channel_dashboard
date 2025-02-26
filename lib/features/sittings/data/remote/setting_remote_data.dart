import 'dart:developer';

import '../../../../core/networking/api_client.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/exception.dart';
import '../models/iptv_config_model.dart';

abstract class SettingRemoteData {
  addIptvConfigSettingsUser({required IptvConfig iptvConfig});
  getAllIptvConfigSttingsUser();
  setAllowUseIptvConfigSttingsUser({required String id});
}

class SettingsRemoteDataImplHttp implements SettingRemoteData {
  final ApiClent apiClent;

  SettingsRemoteDataImplHttp({required this.apiClent});
  @override
  Future<bool> addIptvConfigSettingsUser(
      {required IptvConfig iptvConfig}) async {
    final resalt = await apiClent.posData(
        body: iptvConfig.toJson(),
        uri: ApiConstants.apiBaseUrl +
            ApiConstants.settings +
            ApiConstants.addSettings);

    if (resalt.statusCode == 201) {
      return true;
    } else {
      log(resalt.body.toString());
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<List<IptvConfig>> getAllIptvConfigSttingsUser() async {
    final resalt = await apiClent.getData(
        uri: ApiConstants.apiBaseUrl +
            ApiConstants.settings +
            ApiConstants.getAllSettings);
    if (resalt.statusCode == 200) {
      return IptvConfig.fromJsonList(resalt.body);
    } else {
      log(resalt.body.toString());
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<bool> setAllowUseIptvConfigSttingsUser({required String id}) async {
    final resalt = await apiClent.posData(
        body: {"id": id},
        uri: ApiConstants.apiBaseUrl +
            ApiConstants.settings +
            ApiConstants.setAllowUse);
    if (resalt.statusCode == 200) {
      return true;
    } else {
      log(resalt.body.toString());
      throw ServerException(message: "${resalt.statusCode}");
    }
  }
}
