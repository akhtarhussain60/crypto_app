import 'package:crypto_app/src/src.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnotherScreen extends StatefulWidget {
  const AnotherScreen({super.key});

  @override
  State<AnotherScreen> createState() => _AnotherScreenState();
}

class _AnotherScreenState extends State<AnotherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c1,
      body: Center(
        child: Lottie.asset('assets/json/splashAnimation.json'),
      ),
    );
  }
}
