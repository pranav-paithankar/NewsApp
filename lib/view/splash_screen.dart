import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_portal/res/color.dart';
import 'package:news_portal/res/size_config.dart';
import 'package:news_portal/utils/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 4),
      () {
        Navigator.of(context).pushReplacementNamed(RoutesName.home);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: SizeConfig.screenHeight * 0.45,
                  width: SizeConfig.screenWidth * 0.85,
                  child: Image.asset(
                    'assets/logo.jpg',
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: SizeConfig.screenHeight * 0.025,
              ),
              const Text(
                "News App",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: AppColors.bgColor,
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.01,
              ),
              const Text(
                "@Developed by PranavPaithankar",
                style: TextStyle(color: AppColors.bgColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
