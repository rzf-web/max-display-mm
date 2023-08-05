import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:max_display_app/helper/theme.dart';
import 'package:max_display_app/view/login/login.controller.dart';
import 'package:max_display_app/view/login/login.page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      home: const LoginPage(),
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(primary: primaryColor),
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        primaryColor: primaryColor,
        fontFamily: GoogleFonts.poppins().fontFamily,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            textStyle: const TextStyle(color: Color(0xFFFFFFFF)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 8.0,
          iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
          titleTextStyle: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
