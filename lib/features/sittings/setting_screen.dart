import 'package:dashboard_tv_channel/features/sittings/data/models/iptv_config_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/helpers/enums.dart';
import '../../responsive.dart';
import '../widget/custom_buttom_widget.dart';
import '../widget/custom_text_form_field_widget.dart';
import '../widget/menu/home_nav_bar.dart';
import 'controllers/setting_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context)) const HomeNavBar(title: "Admin"),
          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'IPTV CONFIG',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showAddIptvDialog(context);
                        },
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  GetBuilder<SettingController>(
                    builder: (controller) => controller.statusReq ==
                            StatusRequest.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : controller.statusReq == StatusRequest.serverFailure
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Please_try_agein_later",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          controller.fetchConfigs();
                                        },
                                        child: const Text("TryAgain"))
                                  ],
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    itemCount: controller.iptvConfigs.length,
                                    itemBuilder: (context, index) {
                                      final iptv =
                                          controller.iptvConfigs[index];

                                      return RadioListTile<int>(
                                        title: Text(iptv.host),
                                        subtitle:
                                            Text("User: ${iptv.username}"),
                                        value: iptv.id,
                                        groupValue: controller.selectedId,
                                        onChanged: (value) {
                                          if (value != null) {
                                            controller.updateConfig(value);
                                          }
                                        },
                                      );
                                    }),
                              ),
                  )

                  // buildSettingField(
                  //   label: 'Your API Key:',
                  //   // hintText: 'Enter API Key',onTap:
                  //   onTap: () {},
                  // ),
                  // const SizedBox(height: 20),
                  // buildSettingField(
                  //   label: 'Change Username:',
                  //   oldLabel: 'Old Username',
                  //   newLabel: 'New Username',
                  //   onTap: () {},
                  // ),
                  // const SizedBox(height: 20),
                  // buildSettingField(
                  //   label: 'Change Password:',
                  //   oldLabel: 'Old Password',
                  //   newLabel: 'New Password',
                  //   onTap: () {},
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildSettingField(
    {required String label,
    String? oldLabel,
    String? newLabel,
    void Function()? onTap}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          if (oldLabel != null)
            Expanded(
              child: CustomTextFormField(
                // decoration: InputDecoration(hintText: oldLabel),
                hintText: oldLabel,
              ),
            ),
          const SizedBox(width: 10),
          Expanded(
            child: CustomTextFormField(
              // decoration: InputDecoration(hintText: newLabel ?? 'Enter Value'),
              hintText: newLabel ?? 'Enter Value',
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      CustomButtom(
          onTap: onTap,
          width: 180.w,
          height: 50.h,
          color: Colors.blue,
          title: 'Save')
    ],
  );
}

void showAddIptvDialog(BuildContext context) {
  final SettingController controller = Get.find();
  TextEditingController hostController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Get.dialog(
    AlertDialog(
      title: const Text("Add New IPTV Config"),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: hostController,
              decoration: const InputDecoration(labelText: "Host"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter host URL";
                }
                return null;
              },
            ),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Username"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter username";
                }
                return null;
              },
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter password";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              controller.addIptvConfig(
                iptvConfig: IptvConfig(
                    id: 0,
                    host: hostController.text,
                    username: usernameController.text,
                    password: passwordController.text,
                    allowUse: 0),
              );
              Get.back();
            }
          },
          child: const Text("Add"),
        ),
      ],
    ),
  );
}
