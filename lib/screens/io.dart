import 'dart:async';
import 'package:crypto_app/screens/splash.dart';
import 'package:crypto_app/src/src.dart';
import 'package:flutter/material.dart';

class IO extends StatefulWidget {
  const IO({super.key});

  @override
  State<IO> createState() => _IOState();
}

class _IOState extends State<IO> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SplashScreen()));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: c1,
        body: SizedBox(
          height: myHeight,
          width: myWidth,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: myHeight * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(''),
                Text(
                  'Crypto App',
                  style: TextStyle(
                      fontSize: 60, color: white, fontWeight: FontWeight.w500),
                ),
                Column(
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: [
                    //     const Text(
                    //       'Creat by',
                    //       style: TextStyle(
                    //           fontSize: 20,
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.normal),
                    //     ),
                    //     SizedBox(
                    //       width: myWidth * 0.02,
                    //     ),
                    //     Image.asset(
                    //       'assets/images/io.png',
                    //       height: myHeight * 0.03,
                    //       color: Colors.black,
                    //     )
                    //   ],
                    // ),
                    SizedBox(
                      height: myHeight * 0.005,
                    ),
                    Image.asset(
                      'assets/images/loading1.gif',
                      height: myHeight * 0.06,
                      color: white,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
