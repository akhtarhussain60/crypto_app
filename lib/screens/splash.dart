import 'package:crypto_app/screens/nav_Bar.dart';
import 'package:crypto_app/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: myHeight,
          width: myWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Lottie.asset('assets/json/splashAnimation.json'),
              const Column(
                children: [
                  Text(
                    'The Future',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic),
                  ),
                  Text(
                    'Learn more about cryptocurrency, look to \nthe future in IO Crypto',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: myWidth * 0.18),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NavBar(),
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: myHeight * 0.013, horizontal: myWidth * 0.05),
                    decoration: BoxDecoration(
                        color: c1, borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'CREATE PORTFOLIO  ',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: white),
                        ),
                        RotationTransition(
                            turns: const AlwaysStoppedAnimation(310 / 360),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: white,
                            ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
