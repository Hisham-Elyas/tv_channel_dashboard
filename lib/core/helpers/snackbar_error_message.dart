import 'package:get/get.dart';

import '../widgets/custom_snackbar.dart';

showErrorMessage(String? message) {
  if (message == null) {
    return;
  }
  if (message == '404') {
    showCustomSnackBar(
        message: "Item is already assigned to this Category",
        title: "Item_Already_Assigned".tr,
        isError: true);
  } else if (message == '409') {
    showCustomSnackBar(
        message: "", title: "No_valid_entry_found".tr, isError: true);
  } else {
    showCustomSnackBar(
        message: "Please_try_agein_later".tr,
        title: "Unexpected_Error".tr,
        isError: true);
  }
}

showNetworkError() {
  showCustomSnackBar(
      message: "Ckeck_your_Internet".tr,
      title: "Network_Info".tr,
      isError: true);
}
