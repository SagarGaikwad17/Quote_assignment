import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quote/utils/routes/routes_name.dart';

class SplashServices {
  //Trying to get the data which we stored as Shared Preferences
  //Getter method of UserViewModel

  void checkAuthentication(BuildContext context) async {
    Future.delayed(const Duration(seconds: 3),
            () => Navigator.pushNamed(context, RoutesName.homePage))
        .onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
    });
  }
}
