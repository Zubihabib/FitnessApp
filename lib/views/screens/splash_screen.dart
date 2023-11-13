import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import '../../utils/navigator.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _checkUserSession() {
    bool value = false;
    if (value) {
      navigateAndRemoveUntil(context: context, screen: const HomeScreen());
    } else {
      navigateAndRemoveUntil(context: context, screen: const LoginScreen());
    }
  }

  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      _checkUserSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: AppColor.primaryColor,
        alignment: Alignment.center,
        child: SizedBox(
          width: deviceWidth * 0.4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Fitness App',
                style: primaryTextStyle,
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                    height: 50, width: 50, child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
