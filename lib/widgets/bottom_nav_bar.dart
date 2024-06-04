import 'dart:math';

import 'package:campus_olx/screens/home_screen.dart';
import 'package:campus_olx/screens/profile_screen.dart';
import 'package:campus_olx/screens/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [HomeScreen(), UploadScreen(), ProfileScreen()],
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.white,
            tabActiveBorder: Border.all(color: Colors.black, width: 1),
            tabBackgroundColor: Colors.white,
            padding: EdgeInsets.all(16),
            gap: 5,
            iconSize: 24,
            tabs: [
              GButton(
                icon: Icons.home_outlined,
                iconColor: Colors.black,
                text: 'Home',
              ),
              GButton(
                icon: Icons.upload_file,
                text: 'Upload',
                iconColor: Colors.black,
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
                iconColor: Colors.black,
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: onTapped,
          ),
        ),
      ),
    );
  }
}
