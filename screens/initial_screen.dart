import 'package:flutter/material.dart';
import 'package:resto/screens/home_screen.dart';
import 'package:resto/screens/profile_screen.dart';
import 'package:resto/screens/second_screen.dart';

import '../utils/constants.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  int _currentIndex = 0;

  final List screens = const [
    HomeScreen(),
    SecondScreen(),
    ProfileScreen(),
  ];

  void selectScreen(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: 80,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            iconSize: 40,
            backgroundColor: defaultColor,
            selectedItemColor: icolor,
            onTap: selectScreen,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                activeIcon: ImageIcon(
                  AssetImage("assets/bnb/homeAct.png"),
                ),
                icon: ImageIcon(
                  AssetImage("assets/bnb/home.png"),
                  color: ibcolor,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: ImageIcon(
                  AssetImage("assets/bnb/notebookAct.png"),
                ),
                icon: ImageIcon(
                  AssetImage("assets/bnb/notebook.png"),
                  color: ibcolor,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: ImageIcon(
                  AssetImage("assets/bnb/profileAct.png"),
                ),
                icon: ImageIcon(
                  AssetImage("assets/bnb/profile.png"),
                  color: ibcolor,
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
