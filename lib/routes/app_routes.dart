part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const login = _Paths.login;
  static const rack = _Paths.rack;
  static const product = _Paths.product;
}

abstract class _Paths {
  static const login = '/login';
  static const rack = '/rack';
  static const product = '/Product';
}
