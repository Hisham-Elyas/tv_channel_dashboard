import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color.dart';
import 'login/login_screen.dart';
import 'main_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1728, 1117),
      builder: (context, child) => GetMaterialApp(
        title: 'Tv Admin Dashboard',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "ElMessiri",
          drawerTheme: const DrawerThemeData(
            backgroundColor: AppColor.backgroundColor2,
            surfaceTintColor: AppColor.backgroundColor2,
          ),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.mainColor)
              .copyWith(surface: AppColor.backgroundColor),
        ),
        // home: const MainScreen(),
        home: const LoginScreen(),
      ),
    );
  }
}
