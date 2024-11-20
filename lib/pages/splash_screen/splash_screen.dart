import 'package:flutter/material.dart';
import 'package:mirror_wall_app/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
          () {
        Navigator.pushReplacementNamed(context, AppRoutes.homepage);
      },
    );
    super.initState();
  }


  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image:
          AssetImage(
              'assets/images/browser.png'
          ),
          fit: BoxFit.cover,

        ),
      ),
    );
  }
}

