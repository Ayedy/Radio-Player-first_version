import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int menuIndex;
  final Function changeScreen;

  BottomNavigation({this.menuIndex, this.changeScreen});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BottomNavigationBar(
        elevation: 0,
        currentIndex: menuIndex,
        selectedItemColor: Color(0xFFDEFE0E),
        unselectedItemColor: Colors.grey,
        backgroundColor: Color(0xFF263241),
        onTap: (int index) => this.changeScreen(context, index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.radio),
            title: Text(
              "الإذاعات",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text(
              "المفضلة",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
