import 'package:flutter/material.dart';
import 'package:flutter_app/model/home_view_model.dart';
import 'package:flutter_app/model/public_account_view_model.dart';
import 'package:flutter_app/redux/actions/collection_action.dart';
import 'package:flutter_app/redux/actions/home_action.dart';
import 'package:flutter_app/redux/actions/project_action.dart';
import 'package:flutter_app/redux/actions/public_account_action.dart';
import 'package:flutter_app/redux/state/app_state.dart';
import 'package:flutter_app/redux/state/home_state.dart';
import 'package:flutter_app/ui/collections/collection_screen.dart';
import 'package:flutter_app/ui/project/project_screen.dart';
import 'package:flutter_app/ui/public_account/public_account_screen.dart';
import 'package:flutter_app/ui/setting/setting_screen.dart';
import 'package:flutter_app/widget/home_bottom_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'home/home_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  List<String> tabTitles;

  @override
  void initState() {
    super.initState();

    tabTitles = [
      "主页",
      "项目",

      // "收藏",
      "学习",
      "设置",
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Widget _buildContent() {
  //   return Column(children: <Widget>[
  //     Expanded(
  //       child: PageView(
  //         physics: new NeverScrollableScrollPhysics(),
  //         controller: _pageController,
  //         onPageChanged: (index) {
  //           setState(() {
  //             _selectedTab=index;
  //           });
  //         },
  //         children: <Widget>[
  //           HomeScreen(),
  //           ProjectScreen(),
  //           SettingScreen(),
  //           // SettingScreen(),
  //         ],
  //       ),
  //     ),
  //     Container(
  //       color: Colors.white,
  //       width: double.infinity,
  //       child: HomeBottomBar(
  //           selectedTab: _selectedTab,
  //           onTabChanged: (index) {
  //             setState(() {
  //               _selectedTab=index;
  //             });
  //             _pageController.jumpToPage(index);
  //           }),
  //     )
  //   ]);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Public Account", style: TextStyle(color: Colors.black)),
        //   iconTheme: IconThemeData(color: Colors.black),
        //   backgroundColor: Colors.white,
        // ),
        body: StoreConnector<AppState, HomeViewModel>(
            onInit: (store) {
              //初始化的时候获取数据 根据数据显示是加载中还是显示内容
              store.dispatch(LoadStatusAction(status: LoadingStatus.loading));
              store.dispatch(refreshBannerDataAction(context));
              store.dispatch(loadHomeArticleAction(true));
              store.dispatch(requestCollectionData(true));
              store.dispatch(requestProjectClassifyAction());
            },
            converter: (store) => HomeViewModel.fromStore(store),
            builder: (BuildContext context, HomeViewModel viewModel) {
              return DefaultTabController(
                length: tabTitles.length,
                child: Column(
                  children: <Widget>[
                    _buildContent(),
                    _buildAccountTitle(),
                  ],
                ),
              );
            }));
  }

  Widget _buildContent() {
    return Expanded(
        child: TabBarView(children: <Widget>[
      HomeScreen(),
      ProjectScreen(),
      // CollectionScreen(),
      PublicAccountScreen(),
      SettingScreen(),
    ]));
  }

  Widget _buildAccountTitle() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: TabBar(
        isScrollable: false,
        labelColor: Colors.green,
        indicatorColor: Colors.red,
        //选中下划线的颜色
        unselectedLabelColor: Colors.black,
        labelPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        tabs: tabTitles.map((title) => Text(title)).toList(),
      ),
    );
  }
}
