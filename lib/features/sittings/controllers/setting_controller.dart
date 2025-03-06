import 'package:get/get.dart';

import '../../../core/helpers/coustom_overlay.dart';
import '../../../core/helpers/enums.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../data/models/iptv_config_model.dart';
import '../data/repos/setting_repo.dart';

class SettingController extends GetxController {
  late StatusRequest statusReq;
  SettingRepoImpHttp settingRepo = Get.find();

  List<IptvConfig> iptvConfigs = [];
  int selectedId = -1; // Stores the selected IPTV config ID

  @override
  void onInit() {
    super.onInit();
    fetchConfigs();
  }

  Future<void> fetchConfigs() async {
    statusReq = StatusRequest.loading;
    update();
    final response = await settingRepo.getAllIptvConfigSttingsUser();

    response.fold(
      (l) {
        statusReq = l;
        showCustomSnackBar(
            message: "Failed to fetch IPTV configurations",
            isError: true,
            title: "Error");
        update();
      },
      (r) {
        iptvConfigs = r;
        // Set selected ID to the one with allow_use == 1
        selectedId = iptvConfigs
                .firstWhereOrNull((config) => config.allowUse == 1)
                ?.id ??
            -1;
        statusReq = StatusRequest.success;
        update();
      },
    );
  }

  Future<void> updateConfig(int newId) async {
    showCustomSnackBar(
        message: "FIPTV Configuration Updating", title: "loading");

    await showOverlay(
      asyncFunction: () async {
        final response = await settingRepo.setAllowUseIptvConfigSttingsUser(
            id: newId.toString());

        if (response == true) {
          // Update local list to reflect the change
          for (var config in iptvConfigs) {
            config.allowUse = (config.id == newId) ? 1 : 0;
          }

          selectedId = newId;
          update();
          showCustomSnackBar(
              message: "IPTV Configuration Updated", title: "Success");
        } else {
          showCustomSnackBar(
              message: "Failed to update IPTV configuration",
              title: "Error",
              isError: true);
        }
      },
    );
  }

  Future<void> addIptvConfig({required IptvConfig iptvConfig}) async {
    await showOverlay(
      asyncFunction: () async {
        final response =
            await settingRepo.addIptvConfigSettingsUser(iptvConfig: iptvConfig);

        if (response == true) {
          fetchConfigs(); // Refresh the list
          showCustomSnackBar(
              message: "New IPTV configuration added!", title: "Success");
        } else {
          showCustomSnackBar(
              message: "Failed to add IPTV configuration",
              title: "Error",
              isError: true);
        }
      },
    );
  }
}
