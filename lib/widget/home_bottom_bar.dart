import 'package:flutter/material.dart';

class HomeBottomBar extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  HomeBottomBar({@required this.selectedTab, @required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.green,
        currentIndex: selectedTab,
        onTap: (index) => onTabChanged(index),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create_new_folder),
            title: Text("Project"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Setting"),
          ),
        ],
      ),
    );
  }
}
