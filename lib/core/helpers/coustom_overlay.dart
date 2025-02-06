import 'package:flutter/material.dart';
import 'package:get/get.dart';

showOverlay({required Future<void> Function() asyncFunction}) {
  Get.showOverlay(
      asyncFunction: asyncFunction,
      loadingWidget: const Center(
        child: CircularProgressIndicator(),
      ));
}
