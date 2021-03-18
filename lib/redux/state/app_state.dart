import 'package:flutter/cupertino.dart';
import 'package:flutter_app/redux/state/home_state.dart';
import 'package:flutter_app/redux/state/project_state.dart';
import 'package:meta/meta.dart';

import 'login_state.dart';

@immutable
class AppState {
  final LoginState loginState;
  final HomeState homeState;
  final ProjectState projectState;
  AppState({
    this.loginState,
    this.homeState,
    this.projectState,
});

  factory AppState.initial() {
    return AppState(
      loginState: LoginState.initial(),
      homeState: HomeState.initial(),
      projectState: ProjectState.initial(),
    );
  }
}
