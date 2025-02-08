import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future showOverlay({required Future<void> Function() asyncFunction}) async {
  await Get.showOverlay(
      asyncFunction: asyncFunction,
      loadingWidget: const Center(
        child: CircularProgressIndicator(),
      ));
}
