import 'package:flutter/material.dart';
import 'package:news_portal/view/category_screen.dart';
import 'package:news_portal/view/home_screen.dart';
import 'package:news_portal/view/user-module/login_screen.dart';
import 'package:news_portal/view/news_screen.dart';
import 'package:news_portal/view/user-module/signup_screen.dart';
import 'package:news_portal/view/splash_screen.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RoutesName.splashscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case RoutesName.signupscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpScreen());
      case RoutesName.loginscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case RoutesName.newsscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => NewsScreen());
      case RoutesName.categoryscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => CategoryScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
