import 'package:flutter/material.dart';
import 'package:flutter_app/ui/project/project_screen.dart';
import 'package:flutter_app/ui/setting/setting_screen.dart';
import 'package:flutter_app/widget/home_bottom_bar.dart';

import 'home/home_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int _selectedTab = 0;
  TabController _tabController;
  List<String> tabTitles;
  PageController _pageController = PageController(keepPage: true);

  @override
  void initState() {
    super.initState();

    tabTitles = [
      "主页",
      "项目",
      "项目",
    ];
    _tabController = TabController(length: tabTitles.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget _buildContent() {
    return Column(children: <Widget>[
      Expanded(
        child: PageView(
          physics: new NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedTab=index;
            });
          },
          children: <Widget>[
            HomeScreen(),
            ProjectScreen(),
            SettingScreen(),
            // SettingScreen(),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        width: double.infinity,
        child: HomeBottomBar(
            selectedTab: _selectedTab,
            onTabChanged: (index) {
              setState(() {
                _selectedTab=index;
              });
              _pageController.jumpToPage(index);
            }),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildContent());
  }
}
