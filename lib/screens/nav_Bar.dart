import 'package:crypto_app/screens/anotherScreen.dart';
import 'package:crypto_app/screens/home.dart';
import 'package:crypto_app/src/src.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  List<Widget> screens = [
    const Home(),
    const AnotherScreen(),
    const AnotherScreen(),
    const AnotherScreen(),
    const AnotherScreen()
  ];

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: screens.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
            enableFeedback: false,
            currentIndex: _currentIndex,
            elevation: 2,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.white,
            onTap: (value) {
              setState(() {
                _currentIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/1.1.png',
                    height: myHeight * 0.03,
                    color: Colors.grey,
                  ),
                  activeIcon: Image.asset(
                    'assets/icons/1.2.png',
                    height: myHeight * 0.03,
                    color: c1,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/2.1.png',
                    height: myHeight * 0.03,
                    color: Colors.grey,
                  ),
                  activeIcon: Image.asset(
                    'assets/icons/2.2.png',
                    height: myHeight * 0.03,
                    color: c1,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/3.1.png',
                    height: myHeight * 0.03,
                    color: Colors.grey,
                  ),
                  activeIcon: Image.asset(
                    'assets/icons/3.2.png',
                    height: myHeight * 0.03,
                    color: c1,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/4.1.png',
                    height: myHeight * 0.03,
                    color: Colors.grey,
                  ),
                  activeIcon: Image.asset(
                    'assets/icons/4.2.png',
                    height: myHeight * 0.03,
                    color: c1,
                  ),
                  label: ''),
            ]),
      ),
    );
  }
}
