import 'package:flutter_app/redux/reducer/home_reducer.dart';
import 'package:flutter_app/redux/reducer/project_reducer.dart';
import 'package:flutter_app/redux/state/app_state.dart';

import 'login_reducer.dart';

AppState appReducer(AppState appState, dynamic action) {
  return AppState(
    loginState: loginReducer(appState.loginState, action),
    homeState: homeReducer(appState.homeState,action),
    projectState: projectReducer(appState.projectState,action),
  );
}
