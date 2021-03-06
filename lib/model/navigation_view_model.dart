import 'package:flutter/material.dart';
import 'package:flutter_app/data/navigation_bean.dart';
import 'package:flutter_app/redux/state/app_state.dart';
import 'package:flutter_app/redux/state/home_state.dart';
import 'package:redux/redux.dart';

class NavigationViewModel {
  final LoadingStatus status;
  final List<NavigationData> navigationList;

  NavigationViewModel({@required this.status, @required this.navigationList});

  static NavigationViewModel fromStore(Store<AppState> store) {
    return NavigationViewModel(
        status: store.state.navigationState.status,
        navigationList: store.state.navigationState.navigationList);
  }
}
