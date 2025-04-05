import 'dart:async';
import 'package:flutter/material.dart';
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

    // Animate loading bar
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignUpScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
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
                    color: const Color(0xFF2697FF),
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
