import 'dart:async';
import 'package:admin/core/constants/colors.dart';
import 'package:admin/features/home/presentation/pages/home_screen.dart';
import 'package:admin/features/nav/app_navigation.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
      )
      ..forward().then((_) {
        navigate();
      });
  }

  navigate() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Flexify.go(const AppNavigation());
    } else {
      Flexify.go(const SignUpScreen());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/calendar.svg',
              height: 120,
              width: 120,
            ),
            const SizedBox(height: 24),
            const Text(
              'Calender.io',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2A2D3E),
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: 200,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _controller.value,
                    backgroundColor: Colors.grey.shade300,
                    color: blue,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
