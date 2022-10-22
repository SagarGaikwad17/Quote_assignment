import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quote/utils/routes/routes_name.dart';
import 'package:quote/view/author_page.dart';
import 'package:quote/view/author_quote_page.dart';

import 'package:quote/view/splash_view.dart';

import '../../view/favourite_page.dart';
import '../../view/home_page.dart';
import '../../view/search_page.dart';

class Routes {
  //settings accept string parameter
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homePage:
        return MaterialPageRoute(builder: (BuildContext context) => HomePage());
      case RoutesName.authorPage:
        return MaterialPageRoute(
            builder: (BuildContext context) => AuthorPage());
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());
      case RoutesName.searchPage:
        return MaterialPageRoute(
            builder: (BuildContext context) => SearchPage());
      case RoutesName.favouritePage:
        return MaterialPageRoute(
            builder: (BuildContext context) => FavouritePage());
      case RoutesName.authorQuotePage:
        return MaterialPageRoute(
            builder: (BuildContext context) => AuthorQuotePage());
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Scaffold(
                  body: Center(
                    child: Text("No route defined"),
                  ),
                ));
    }
  }
}
