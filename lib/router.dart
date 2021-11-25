import 'package:flutter/material.dart';
import 'package:nubank_marketplace/features/pivots/home_page.dart';
import 'package:nubank_marketplace/features/pivots/splash_page.dart';

class NubankMarketplaceRouter {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (context) => HomePage());
      default:
        return MaterialPageRoute(builder: (context) => SplashPage());
    }
  }
}
