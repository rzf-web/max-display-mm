import 'package:get/get.dart';
import 'package:max_display_app/binding/login.binding.dart';
import 'package:max_display_app/binding/product.binding.dart';
import 'package:max_display_app/binding/rack.binding.dart';
import 'package:max_display_app/view/login/login.page.dart';
import 'package:max_display_app/view/product_list/product.page.dart';
import 'package:max_display_app/view/rack_list/rack.page.dart';

part 'app_routes.dart';

abstract class AppPages {
  AppPages._();

  static const _transition = Transition.fadeIn;
  static const initialPage = Routes.login;

  static var pages = <GetPage>[
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: _transition,
    ),
    GetPage(
      name: Routes.rack,
      page: () => const RackPage(),
      binding: RackBinding(),
      transition: _transition,
    ),
    GetPage(
      name: Routes.product,
      page: () => const ProductPage(),
      binding: ProductBinding(),
      transition: _transition,
    ),
  ];
}
