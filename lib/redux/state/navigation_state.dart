import 'package:flutter/material.dart';
import 'package:flutter_app/data/navigation_bean.dart';
import 'package:flutter_app/redux/state/home_state.dart';

@immutable
class NavigationState {
  final LoadingStatus status;
  final List<NavigationData> navigationList;

  NavigationState({@required this.status, @required this.navigationList});

  factory NavigationState.initial() {
    return NavigationState(status: LoadingStatus.idle, navigationList: []);
  }

  NavigationState copyWith(
      LoadingStatus status, List<NavigationData> navigationList) {
    return NavigationState(
        status: status ?? this.status,
        navigationList: navigationList ?? this.navigationList);
  }
}
