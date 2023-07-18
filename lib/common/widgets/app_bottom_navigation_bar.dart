import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pssn/features/home/home_page.dart';
import 'package:pssn/features/profile/screens/profile_page.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key});

  @override
  State<StatefulWidget> createState() => AppBottomNavigationBarState();
}

class AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int currentIndex = 0;

  static const items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      currentIndex: currentIndex,
      selectedItemColor: Colors.black,
      onTap: (int index) {
        switch (index) {
          case 0:
            currentIndex = 0;
            GoRouter.of(context).go(HomePage.path);
            break;
          case 1:
            currentIndex = 1;
            GoRouter.of(context).go(ProfilePage.path);
            break;
        }
      },
    );
  }
}
